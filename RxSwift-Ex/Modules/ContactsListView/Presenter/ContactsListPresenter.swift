//
//  ContactsListPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

struct ContactModel {
    let name: String
    let phone: String
}

struct ContactsModel {
    let list: [ContactModel]
}

final class ContactsListPresenter {
    typealias View = ContactsListViewInput
    typealias Interactor = ContactsListInteractorInput
    typealias Router = ContactsListRouterInput
    
    private weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    private var contacts: [ContactModel] = [] {
        willSet {
            view.reload()
        }
    }
    
    required init(with view: View) {
        self.view = view
    }
}

//MARK: ContactsListViewOutput
extension ContactsListPresenter: ContactsListViewOutput {
    var contactsList: [ContactModel] { contacts }
    
    func didLoad() {
        view.didSetNavBarTitle("Контакты")
        
        interactor.makeContacts()
    }
    
    func didSelect(_ index: Int) {
        router.pushContactModule(with: contactsList[index])
    }
}

//MARK: ContactsListInteractorOutput
extension ContactsListPresenter: ContactsListInteractorOutput {
    func didSetContacts(_ contacts: [ContactModel]) {
        self.contacts = contacts
    }
}