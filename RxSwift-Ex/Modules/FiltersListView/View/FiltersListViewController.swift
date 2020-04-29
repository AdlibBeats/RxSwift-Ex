//
//  FiltersListViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class FiltersListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue?.delegate = self
            newValue?.dataSource = self
            newValue?.register(
                .init(nibName: cellIdentifier, bundle: nil),
                forCellReuseIdentifier: cellIdentifier
            )
        }
    }
    
    private let cellIdentifier = "FiltersListTableViewCell"
    
    var output: FiltersListViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Фильтры"
        
        navigationItem.backBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            barButtonItem.tintColor = .navBarTextColor
            return barButtonItem
        }()
        
        output.viewDidLoad()
    }
}

//MARK: UITableViewDelegate
extension FiltersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 16 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 0 ? 16 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 56 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let output = output, !output.filtersList.check(index: indexPath.row) { return }
        output?.tableViewDidSelect(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: UITableViewDataSource
extension FiltersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output?.filtersList.count ?? 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = .separatorColor
            return view
        }()
        
        if let output = output, !output.filtersList.check(index: indexPath.row) { return cell }
        (cell as? FiltersListTableViewCell).flatMap {
            $0.filter = output?.filtersList[indexPath.row]
        }
        return cell
    }
}

//MARK: FiltersListViewInput
extension FiltersListViewController: FiltersListViewInput {
    func reload() {
        tableView?.reloadData()
    }
}

private extension Array {
    func check(index: Int) -> Bool { index >= 0 && index < count }
}
