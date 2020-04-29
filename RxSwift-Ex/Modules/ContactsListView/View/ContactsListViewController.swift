//
//  ContactsListViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import RealmSwift

final class ContactsListViewController: UIViewController {
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
    
    private let cellIdentifier = "ContactsListTableViewCell"
    
    private let configurator: ContactsListConfiguratorProtocol = ContactsListConfigurator()
    
    var output: ContactsListViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Контакты"
        
        navigationItem.backBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            barButtonItem.tintColor = UIColor(red: 0.306, green: 0.380, blue: 0.451, alpha: 1)
            return barButtonItem
        }()
        
        configurator.configure(with: self)
        output?.viewDidLoad()
    }
    
    @IBAction private func filterBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        output?.filterDidTap()
    }
    
    @IBAction private func searchBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        output?.searchDidTap()
    }
}

//MARK: UITableViewDelegate
extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 16 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 0 ? 16 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 56 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let output = output, !output.contactsList.check(index: indexPath.row) { return }
        output?.tableViewDidSelect(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: UITableViewDataSource
extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output?.contactsList.count ?? 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = .init(red: 0.898, green: 0.898, blue: 0.898, alpha: 0.1)
            return view
        }()
        
        if let output = output, !output.contactsList.check(index: indexPath.row) { return cell }
        (cell as? ContactsListTableViewCell).flatMap {
            $0.delegate = self
            $0.contact = output?.contactsList[indexPath.row]
        }
        return cell
    }
}

//MARK: ContactsListViewInput
extension ContactsListViewController: ContactsListViewInput {
    func reload() {
        tableView?.reloadData()
    }
}

//MARK: ContactsListTableViewCellDelegate
extension ContactsListViewController: ContactsListTableViewCellDelegate {
    func videoCall(to contact: Contact) {
        output?.videoCallDidTap(contact)
    }
    
    func audioCall(to contact: Contact) {
        output?.audioCallDidTap(contact)
    }
}

private extension Array {
    func check(index: Int) -> Bool { index >= 0 && index < count }
}
