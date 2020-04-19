//
//  ContactAssembly.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

typealias ContactModule = BaseModule<ContactModuleInput, ContactModuleOutput>

extension Assembly {
    static func createModule(_ module: ContactModule.Type, output: ContactModuleOutput?) -> ContactModule {
        let storyboard = UIStoryboard(name: "ContactView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ContactViewController")
        let contactViewController = viewController as! ContactViewController
        let presenter = ContactPresenter(with: contactViewController)
        let interactor = ContactInteractor(with: presenter)
        let router = ContactRouter()
        
        contactViewController.output = presenter
        router.transitionHandler = contactViewController
        presenter.interactor = interactor
        presenter.router = router
        
        return ContactModule(view: contactViewController, input: presenter, output: output)
    }
}
