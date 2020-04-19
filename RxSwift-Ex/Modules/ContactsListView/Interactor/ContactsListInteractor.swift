//
//  ContactsListInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

final class ContactsListInteractor {
    weak var output: ContactsListInteractorOutput!
}

//MARK: ContactsListInteractorInput
extension ContactsListInteractor: ContactsListInteractorInput {
    func makeContacts() {
        guard let entityService = Container.shared.resolve(EntityServiceProtocol.self) else { return }
        output.didSetContacts(
            entityService.makeContacts().list.toArray().map {
                ContactModel(name: $0.name, phone: $0.phone)
            }
        )
    }
}
