//
//  ContactPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

final class ContactPresenter {
    typealias View = ContactViewInput
    typealias Interactor = ContactInteractorInput
    typealias Router = ContactRouterInput
    typealias Output = ContactModuleOutput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router?
    var output: Output?
    
    
    
    private var contact = ContactModel(
        id: 0,
        active: false,
        login: "",
        firstName: "",
        lastName: "",
        middleName: "",
        position: "",
        email: "",
        level: "",
        roles: [],
        divisions: [],
        regions: [],
        shops: [],
        directorOfShops: [],
        businessDirId: 0,
        lang: ""
    )
}

extension ContactPresenter: ContactViewOutput {
    func viewDidLoad() {
        view.setNavBarTitle("Контакт")
        view.setName(contact.firstName)
        view.setPhone(contact.position)
    }
    
    func backDidTap() {
        router?.goBack()
    }
}

extension ContactPresenter: ContactInteractorOutput {
    
}

extension ContactPresenter: ContactModuleInput {
    func didSetContact(_ newValue: ContactModel) {
        contact = newValue
    }
}
