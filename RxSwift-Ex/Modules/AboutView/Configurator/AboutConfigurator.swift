//
//  AboutConfigurator.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol AboutConfiguratorProtocol: class {
    func configure(with viewController: AboutViewController)
}

final class AboutConfigurator: AboutConfiguratorProtocol {
    func configure(with viewController: AboutViewController) {
        let presenter = AboutPresenter(view: viewController)
        let interactor = AboutInteractor(presenter: presenter)
        let router = AboutRouter()
        
        viewController.presenter = presenter
        router.transitionHandler = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
