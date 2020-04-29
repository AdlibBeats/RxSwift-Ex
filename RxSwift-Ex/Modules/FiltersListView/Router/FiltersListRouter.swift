//
//  FiltersListRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import WebKit
import Swinject

final class FiltersListRouter {
    weak var transitionHandler: TransitionHandler?
}

// MARK: ContactsListRouterInput
extension FiltersListRouter: FiltersListRouterInput {
    func goToConcreteFilter(with filter: Filter) {
        /* let module = Assembly.createModule(FilterModule.self, output: nil)
        transitionHandler?.pushModule(module.view, animated: true)
        module.input?.setFilter(filter) */
    }
}
