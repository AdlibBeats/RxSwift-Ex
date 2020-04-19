//
//  RxAboutConfigurator.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

protocol RxAboutConfiguratorProtocol: class {
    func configure(with viewController: RxAboutViewController)
}

final class RxAboutConfigurator: RxAboutConfiguratorProtocol {
    func configure(with viewController: RxAboutViewController) {
        let presenter = RxAboutPresenter()
        let interactor = RxAboutInteractor(container: Container.shared)
        let router = RxAboutRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
