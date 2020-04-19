//
//  ContactsListConfigurator.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

protocol ContactsListConfiguratorProtocol: class {
    func configure(with viewController: ContactsListViewController)
}

final class ContactsListConfigurator: ContactsListConfiguratorProtocol {
    func configure(with viewController: ContactsListViewController) {
        let presenter = ContactsListPresenter(with: viewController)
        let interactor = ContactsListInteractor(with: presenter, container: Container.shared)
        let router = ContactsListRouter()
        
        viewController.output = presenter
        router.transitionHandler = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
