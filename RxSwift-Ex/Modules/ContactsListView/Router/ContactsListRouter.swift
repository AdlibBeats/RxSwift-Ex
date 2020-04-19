//
//  ContactsListRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import WebKit
import Swinject

final class ContactsListRouter {
    weak var transitionHandler: TransitionHandler?
}

// MARK: ContactsListRouterInput
extension ContactsListRouter: ContactsListRouterInput {
    func pushContactModule(with contact: ContactModel) {
        let module = Assembly.createModule(ContactModule.self, output: nil)
        transitionHandler?.pushModule(module.view, animated: true)
        module.input?.didSetContact(contact)
    }
}
