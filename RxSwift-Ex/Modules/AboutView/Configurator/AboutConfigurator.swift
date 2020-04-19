//
//  AboutConfigurator.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

protocol AboutConfiguratorProtocol: class {
    func configure(with viewController: AboutViewController)
}

final class AboutConfigurator: AboutConfiguratorProtocol {
    func configure(with viewController: AboutViewController) {
        let presenter = AboutPresenter(with: viewController)
        let interactor = AboutInteractor(with: presenter, container: Container.shared)
        let router = AboutRouter()
        
        viewController.output = presenter
        router.transitionHandler = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
