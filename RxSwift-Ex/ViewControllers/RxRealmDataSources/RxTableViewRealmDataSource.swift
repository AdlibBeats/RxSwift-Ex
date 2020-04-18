//
//  RxTableViewRealmDataSource.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm
import UIKit

typealias TableCellFactory<O: Object> = (RxTableViewRealmDataSource<O>, UITableView, IndexPath, O) -> UITableViewCell
typealias TableCellConfig<O: Object, CellType: UITableViewCell> = (CellType, IndexPath, O) -> Void

class RxTableViewRealmDataSource<O: Object>: NSObject, UITableViewDataSource {
    private var items: AnyRealmCollection<O>?

    var tableView: UITableView?
    var animated = true
    var rowAnimations = (
        insert: UITableView.RowAnimation.automatic,
        update: UITableView.RowAnimation.automatic,
        delete: UITableView.RowAnimation.automatic
    )

    var headerTitle: String?
    var footerTitle: String?

    let cellIdentifier: String
    let cellFactory: TableCellFactory<O>

    init(cellIdentifier: String, cellFactory: @escaping TableCellFactory<O>) {
        self.cellIdentifier = cellIdentifier
        self.cellFactory = cellFactory
    }

    init<CellType: UITableViewCell>(cellIdentifier: String, cellType: CellType.Type, cellConfig: @escaping TableCellConfig<O, CellType>) {
        self.cellIdentifier = cellIdentifier
        self.cellFactory = { _, tableView, indexPath, object in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CellType
            cellConfig(cell, indexPath, object)
            return cell
        }
    }
    
    func model(at indexPath: IndexPath) -> O { items![indexPath.row] }
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items?.count ?? 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellFactory(self, tableView, indexPath, items![indexPath.row])
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { headerTitle }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? { footerTitle }
    
    private let fromRow = { IndexPath(row: $0, section: 0) }

    func applyChanges(items: AnyRealmCollection<O>, changes: RealmChangeset?) {
        if self.items == nil {
            self.items = items
        }

        guard let tableView = tableView else {
            fatalError("You have to bind a table view to the data source.")
        }

        guard animated else {
            tableView.reloadData()
            return
        }

        guard let changes = changes else {
            tableView.reloadData()
            return
        }

        let lastItemCount = tableView.numberOfRows(inSection: 0)
        guard items.count == lastItemCount + changes.inserted.count - changes.deleted.count else {
            tableView.reloadData()
            return
        }

        tableView.beginUpdates()
        tableView.deleteRows(at: changes.deleted.map(fromRow), with: rowAnimations.delete)
        tableView.insertRows(at: changes.inserted.map(fromRow), with: rowAnimations.insert)
        tableView.reloadRows(at: changes.updated.map(fromRow), with: rowAnimations.update)
        tableView.endUpdates()
    }
}
