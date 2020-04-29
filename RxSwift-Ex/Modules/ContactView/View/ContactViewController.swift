//
//  ContactViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

final class ContactViewController: UIViewController {
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var shortNameLabel: UILabel!
    @IBOutlet private weak var displayNameLabel: UILabel!
    @IBOutlet private weak var activeTimeLabel: UILabel!
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
    
    private let cellIdentifier = "ContactPropertiesListTableViewCell"
    
    var output: ContactViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Контакт"
        
        navigationItem.backBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            barButtonItem.tintColor = UIColor(red: 0.306, green: 0.380, blue: 0.451, alpha: 1)
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
        section == 0 ? 40 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 0 ? 16 : tableView.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 56 }
}

//MARK: UITableViewDataSource
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { section == 0 ? "Информация" : nil }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output?.propertiesList.count ?? 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
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
        shortNameLabel?.text = newValue
    }
    
    func setDisplayName(_ newValue: String) {
        displayNameLabel?.text = newValue
    }
    
    func setActiveTime(_ newValue: String) {
        activeTimeLabel?.text = newValue
    }
    
    func reload() {
        tableView?.reloadData()
        
        //iOS Bug: tableView.contentSize.height doesn't update tableView height constraint
        tableView.flatMap {
            tableViewHeightConstraint?.constant = $0.contentSize.height
        }
    }
}

private extension Array {
    func check(index: Int) -> Bool { index >= 0 && index < count }
}
