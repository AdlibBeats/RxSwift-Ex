//
//  RxCollectionViewRealmDataSource.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm
import UIKit

typealias CollectionCellFactory<O: Object> = (RxCollectionViewRealmDataSource<O>, UICollectionView, IndexPath, O) -> UICollectionViewCell
typealias CollectionCellConfig<O: Object, CellType: UICollectionViewCell> = (CellType, IndexPath, O) -> Void

class RxCollectionViewRealmDataSource <O: Object>: NSObject, UICollectionViewDataSource {
    private var items: AnyRealmCollection<O>?

    var collectionView: UICollectionView?
    var animated = true
    
    let cellIdentifier: String
    let cellFactory: CollectionCellFactory<O>

    init(cellIdentifier: String, cellFactory: @escaping CollectionCellFactory<O>) {
        self.cellIdentifier = cellIdentifier
        self.cellFactory = cellFactory
    }

    init<CellType: UICollectionViewCell>(cellIdentifier: String, cellType: CellType.Type, cellConfig: @escaping CollectionCellConfig<O, CellType>) {
        self.cellIdentifier = cellIdentifier
        self.cellFactory = { _, collectionView, indexPath, object in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CellType
            cellConfig(cell, indexPath, object)
            return cell
        }
    }
    
    func model(at indexPath: IndexPath) -> O { items![indexPath.row] }
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { items?.count ?? 0 }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellFactory(self, collectionView, indexPath, items![indexPath.row])
    }
    
    private let fromRow = { IndexPath(row: $0, section: 0) }

    func applyChanges(items: AnyRealmCollection<O>, changes: RealmChangeset?) {
        if self.items == nil {
            self.items = items
        }

        guard let collectionView = collectionView else {
            fatalError("You have to bind a collection view to the data source.")
        }

        guard animated else {
            collectionView.reloadData()
            return
        }

        guard let changes = changes else {
            collectionView.reloadData()
            return
        }

        let lastItemCount = collectionView.numberOfItems(inSection: 0)
        guard items.count == lastItemCount + changes.inserted.count - changes.deleted.count else {
            collectionView.reloadData()
            return
        }

        collectionView.performBatchUpdates({ [fromRow] in
            collectionView.deleteItems(at: changes.deleted.map(fromRow))
            collectionView.reloadItems(at: changes.updated.map(fromRow))
            collectionView.insertItems(at: changes.inserted.map(fromRow))
        }, completion: nil)
    }
}
