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
    
    private weak var view: View!
    var interactor: Interactor!
    var router: Router!
    var output: Output?
    
    private var contact = ContactModel(name: "", phone: "")
    
    required init(with view: View) {
        self.view = view
    }
}

extension ContactPresenter: ContactViewOutput {
    func didLoad() {
        view.didSetNavBarTitle("Контакт")
        view.didSetName(contact.name)
        view.didSetPhone(contact.phone)
    }
}

extension ContactPresenter: ContactInteractorOutput {
    
}

extension ContactPresenter: ContactModuleInput {
    func didSetContact(_ newValue: ContactModel) {
        contact = newValue
    }
}
