//
//  ContactsListPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

struct ContactModel {
    let id: Int
    let active: Bool
    let login: String
    let firstName: String
    let lastName: String
    let middleName: String
    let position: String
    let email: String
    let level: String
    let roles: [String]
    let divisions: [Int]
    let regions: [Int]
    let shops: [Int]
    let directorOfShops: [Int]
    let businessDirId: Int
    let lang: String
}

struct ContactsModel {
    let list: [ContactModel]
}

final class ContactsListPresenter {
    typealias View = ContactsListViewInput
    typealias Interactor = ContactsListInteractorInput
    typealias Router = ContactsListRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router?
    
    private var contacts: [ContactModel] = [] {
        willSet {
            view.reload()
        }
    }
}

//MARK: ContactsListViewOutput
extension ContactsListPresenter: ContactsListViewOutput {
    func backDidTap() {
        router?.goBack()
    }
    
    func filterDidTap() {
        //TODO:
    }
    
    func searchDidTap() {
        //TODO:
    }
    
    var contactsList: [ContactModel] { contacts }
    
    func viewDidLoad() {
        interactor.makeContacts()
    }
    
    func tableViewDidSelect(_ index: Int) {
        router?.goToContactModule(with: contactsList[index])
    }
}

//MARK: ContactsListInteractorOutput
extension ContactsListPresenter: ContactsListInteractorOutput {
    func setContacts(_ contacts: [ContactModel]) {
        self.contacts = contacts
    }
}
