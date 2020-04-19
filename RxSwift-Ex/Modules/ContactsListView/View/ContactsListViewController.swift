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
    @IBOutlet weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.register(
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

        configurator.configure(with: self)
        output.didLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem().then {
            $0.tintColor = .init(red: 0.937, green: 0.565, blue: 0.729, alpha: 1)
        }
    }
}

//MARK: UITableViewDelegate
extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 53 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !output.contactsList.check(index: indexPath.row) { return }
        output.didSelect(indexPath.row)
    }
}

//MARK: UITableViewDataSource
extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output.contactsList.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if !output.contactsList.check(index: indexPath.row) { return cell }
        (cell as? ContactsListTableViewCell).flatMap {
            $0.nameLabel.text = output.contactsList[indexPath.row].name
            $0.phoneLabel.text = output.contactsList[indexPath.row].phone
        }
        return cell
    }
}

//MARK: ContactsListViewInput
extension ContactsListViewController: ContactsListViewInput {
    func didSetNavBarTitle(_ newValue: String) {
        title = newValue
    }
    
    func reload() {
        tableView.reloadData()
    }
}

private extension Array {
    func check(index: Int) -> Bool { index >= 0 && index < count }
}
