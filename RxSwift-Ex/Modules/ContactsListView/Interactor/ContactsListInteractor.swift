//
//  ContactsListInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

final class ContactsListInteractor {
    typealias Presenter = ContactsListInteractorOutput
    
    private weak var presenter: Presenter!
    
    private let entityService: EntityServiceProtocol = EntityService()
    
    required init(with presenter: Presenter) {
        self.presenter = presenter
    }
}

extension ContactsListInteractor: ContactsListInteractorInput {
    func makeContacts() {
        presenter.didSetContacts(
            ContactsPresenter(
                list: entityService.makeContacts().list.toArray().map {
                    ContactPresenter(name: $0.name, phone: $0.phone)
                }
            )
        )
    }
}
