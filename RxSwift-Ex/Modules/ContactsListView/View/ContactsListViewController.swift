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
            newValue.delegate = self
            newValue.dataSource = self
            newValue.register(
                .init(nibName: cellIdentifier, bundle: nil),
                forCellReuseIdentifier: cellIdentifier
            )
        }
    }
    
    private let navBarColor = UIColor(red: 0.306, green: 0.380, blue: 0.451, alpha: 1)
    private let cellIdentifier = "ContactsListTableViewCell"
    
    private let configurator: ContactsListConfiguratorProtocol = ContactsListConfigurator()
    
    var output: ContactsListViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Контакты"
        
        navigationController?.navigationBar.tintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = {
            [NSAttributedString.Key.foregroundColor: navBarColor]
        }()
        
        configurator.configure(with: self)
        output.viewDidLoad()
    }
    
    @IBAction func backBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        output.backDidTap()
    }
    
    @IBAction func filterBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        output.filterDidTap()
    }
    
    @IBAction func searchBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        output.searchDidTap()
    }
}

//MARK: UITableViewDelegate
extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 56 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !output.contactsList.check(index: indexPath.row) { return }
        output.tableViewDidSelect(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: UITableViewDataSource
extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output.contactsList.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
            return view
        }()
        
        if !output.contactsList.check(index: indexPath.row) { return cell }
        (cell as? ContactsListTableViewCell).flatMap {
            let contact = output.contactsList[indexPath.row]
            $0.firstCharOfFirstNameLabel.text = contact.firstName[0]
            $0.firstCharOfLastNameLabel.text = contact.lastName[0]
            $0.fullNameLabel.text = "\(contact.lastName) \(contact.firstName) \(contact.middleName)"
            $0.descriptionLabel.text = {
                var value = ""
                contact.roles.forEach { value += "\($0), " }
                value.removeLast(2)
                return value
            }()
        }
        return cell
    }
}

//MARK: ContactsListViewInput
extension ContactsListViewController: ContactsListViewInput {
    func setNavBarTitle(_ newValue: String) {
        title = newValue
    }
    
    func reload() {
        tableView.reloadData()
    }
}

private extension Array {
    func check(index: Int) -> Bool { index >= 0 && index < count }
}

private extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
