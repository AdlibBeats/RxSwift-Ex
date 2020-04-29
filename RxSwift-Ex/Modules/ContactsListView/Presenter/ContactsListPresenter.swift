//
//  ContactsListPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

final class ContactsListPresenter {
    typealias View = ContactsListViewInput
    typealias Interactor = ContactsListInteractorInput
    typealias Router = ContactsListRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router?
    
    private var contacts: Contacts = [] {
        willSet {
            view?.reload()
        }
    }
}

//MARK: ContactsListViewOutput
extension ContactsListPresenter: ContactsListViewOutput {
    func filterDidTap() {
        router?.goToFiltersModule()
    }
    
    func searchDidTap() {
        //TODO:
        print(#function)
    }
    
    func videoCallDidTap(_ contact: Contact) {
        //TODO:
        print(#function)
    }
    
    func audioCallDidTap(_ contact: Contact) {
        //TODO:
        print(#function)
    }
    
    var contactsList: Contacts { contacts }
    
    func viewDidLoad() {
        interactor?.makeContacts()
    }
    
    func tableViewDidSelect(_ index: Int) {
        router?.goToContactModule(with: contactsList[index])
    }
}

//MARK: ContactsListInteractorOutput
extension ContactsListPresenter: ContactsListInteractorOutput {
    func setContacts(_ contacts: Contacts) {
        self.contacts = contacts
    }
}

//MARK: ContactsListModuleInput
extension ContactsListPresenter: ContactsListModuleInput {
    
}
