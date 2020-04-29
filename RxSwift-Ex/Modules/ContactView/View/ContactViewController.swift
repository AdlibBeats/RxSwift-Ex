//
//  ContactViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class ContactViewController: UIViewController {
    private var shortName: String!
    private var displayName: String!
    private var activeTime: String!
    
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue?.delegate = self
            newValue?.dataSource = self
            newValue?.register(
                .init(nibName: cellIdentifier, bundle: nil),
                forCellReuseIdentifier: cellIdentifier
            )
            newValue?.register(
                .init(nibName: headerIdentifer, bundle: nil),
                forHeaderFooterViewReuseIdentifier: headerIdentifer
            )
        }
    }
    
    private let cellIdentifier = "ContactPropertiesListTableViewCell"
    private let headerIdentifer = "ContactPropertiesListHeaderView"
    
    var output: ContactViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Контакт"
        
        navigationItem.backBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            barButtonItem.tintColor = .navBarTextColor
            return barButtonItem
        }()
        
        output?.viewDidLoad()
    }
    
    @IBAction private func messagesBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        output?.messagesDidTap()
    }
    
    @IBAction private func menuBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        output?.menuDidTap()
    }
}

//MARK: UITableViewDelegate
extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 152 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 0 ? 16 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 56 }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ContactPropertiesListHeaderView(frame: .init(x: 0, y: 0, width: tableView.bounds.width, height: 152))
        headerView.activeTime = activeTime
        headerView.displayName = displayName
        headerView.shortName = shortName
        return headerView
    }
}

//MARK: UITableViewDataSource
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output?.propertiesList.count ?? 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = .separatorColor
            return view
        }()
        
        if let output = output, !output.propertiesList.check(index: indexPath.row) { return cell }
        (cell as? ContactPropertiesListTableViewCell).flatMap {
            $0.property = output?.propertiesList[indexPath.row]
        }
        return cell
    }
}

//MARK: ContactViewInput
extension ContactViewController: ContactViewInput {
    func setShortName(_ newValue: String) {
        shortName = newValue
    }
    
    func setDisplayName(_ newValue: String) {
        displayName = newValue
    }
    
    func setActiveTime(_ newValue: String) {
        activeTime = newValue
    }
    
    func reload() {
        tableView?.reloadData()
    }
}

private extension Array {
    func check(index: Int) -> Bool { index >= 0 && index < count }
}
