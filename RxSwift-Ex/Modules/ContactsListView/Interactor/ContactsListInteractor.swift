//
//  ContactsListInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

final class ContactsListInteractor {
    typealias Presenter = ContactsListInteractorOutput
    
    private weak var presenter: Presenter!
    
    private let container: Container
    
    required init(with presenter: Presenter, container: Container) {
        self.presenter = presenter
        self.container = container
    }
}

//MARK: ContactsListInteractorInput
extension ContactsListInteractor: ContactsListInteractorInput {
    func makeContacts() {
        let entityService = container.resolve(EntityServiceProtocol.self)!
        presenter.didSetContacts(
            entityService.makeContacts().list.toArray().map {
                ContactModel(name: $0.name, phone: $0.phone)
            }
        )
    }
}
