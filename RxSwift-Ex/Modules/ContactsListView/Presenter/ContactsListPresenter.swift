//
//  ContactsListPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

struct ContactPresenter {
    let name: String
    let phone: String
}

struct ContactsPresenter {
    let list: [ContactPresenter]
}

final class ContactsListPresenter {
    typealias View = ContactsListViewInput
    typealias Interactor = ContactsListInteractorInput
    typealias Router = ContactsListRouterInput
    
    private weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    private var contacts: [ContactPresenter] = [] {
        willSet {
            view.reload()
        }
    }
    
    required init(with view: View) {
        self.view = view
        
        prepareView()
    }
    
    private func prepareView() {
        view.didSetNavBarTitle("Контакты")
    }
}

extension ContactsListPresenter: ContactsListViewOutput {
    var contactsList: [ContactPresenter] { contacts }
    
    func didLoad() {
        interactor.makeContacts()
    }
    
    func didSelect(_ index: Int) {
        router.pushContactModule(with: contactsList[index])
    }
}

extension ContactsListPresenter: ContactsListInteractorOutput {
    func didSetContacts(_ contacts: [ContactPresenter]) {
        self.contacts = contacts
    }
}
