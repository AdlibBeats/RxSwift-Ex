//
//  ContactRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

final class ContactRouter {
    weak var transitionHandler: TransitionHandler?
}

extension ContactRouter: ContactRouterInput {
    func goBack() {
        transitionHandler?.closeCurrentModule(true)
    }
}
