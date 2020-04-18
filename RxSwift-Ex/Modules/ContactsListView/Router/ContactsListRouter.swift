//
//  ContactsListRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

import Foundation
import WebKit

final class ContactsListRouter {
    weak var transitionHandler: TransitionHandler?
}

// MARK: AboutRouterInput
extension ContactsListRouter: ContactsListRouterInput {
    func pushContactModule(with contact: ContactPresenter) {
        transitionHandler?.pushModule(
            UIViewController(), //ContactViewController
            animated: true
        )
    }
}
