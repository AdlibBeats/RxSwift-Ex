//
//  ContactsListAssembly.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

typealias ContactsListModule = BaseModule<ContactsListModuleInput, ContactsListModuleOutput>

extension Assembly {
    static func createModule(_ module: ContactsListModule.Type, output: ContactsListModuleOutput?) -> ContactsListModule {
        let storyboard = UIStoryboard(name: "ContactsListView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ContactsListViewController")
        let contactsListViewController = viewController as! ContactsListViewController
        let presenter = ContactsListPresenter()
        let interactor = ContactsListInteractor()
        let router = ContactsListRouter()
        
        presenter.view = contactsListViewController
        contactsListViewController.output = presenter
        router.transitionHandler = contactsListViewController
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.router = router
        
        return ContactsListModule(view: contactsListViewController, input: presenter, output: output)
    }
}
