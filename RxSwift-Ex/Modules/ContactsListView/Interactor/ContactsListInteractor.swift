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
        output.setContacts(
            entityService.makeContacts().list.toArray().map {
                ContactModel(
                    id: $0.id,
                    active: $0.active,
                    login: $0.login,
                    firstName: $0.firstName ?? "",
                    lastName: $0.lastName ?? "",
                    middleName: $0.middleName ?? "",
                    position: $0.position ?? "",
                    email: $0.email ?? "",
                    level: $0.level,
                    roles: $0.roles.toArray(),
                    divisions: $0.divisions.toArray(),
                    regions: $0.regions.toArray(),
                    shops: $0.shops.toArray(),
                    directorOfShops: $0.directorOfShops.toArray(),
                    businessDirId: $0.businessDirId,
                    lang: $0.lang ?? ""
                )
            }
        )
    }
}
