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

//MARK: ContactsListConfiguratorProtocol
final class ContactsListConfigurator: ContactsListConfiguratorProtocol {
    func configure(with viewController: ContactsListViewController) {
        let presenter = ContactsListPresenter()
        let interactor = ContactsListInteractor()
        let router = ContactsListRouter()
        
        presenter.view = viewController
        viewController.output = presenter
        router.transitionHandler = viewController
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.router = router
    }
}
