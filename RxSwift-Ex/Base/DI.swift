//
//  DI.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension ObjectScope {
    static let servicesScope = ObjectScope(storageFactory: PermanentStorage.init)
    static let viewControllerScope = ObjectScope(storageFactory: PermanentStorage.init)
}

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container
            .register(EntityServiceProtocol.self, factory: { _ in EntityService() })
            .inObjectScope(.servicesScope)
        
        container
            .register(UINavigationController.self, name: "RxAboutNavigationView", factory: { r in
                let viewController = RxAboutViewController()
                let navigationController = UINavigationController(rootViewController: viewController)
                let presenter = RxAboutPresenter()
                let interactor = RxAboutInteractor(with: r.resolve(EntityServiceProtocol.self)!)
                let router = RxAboutRouter(with: viewController)
                
                viewController.presenter = presenter
                presenter.interactor = interactor
                presenter.router = router
                
                return navigationController
            })
            .inObjectScope(.viewControllerScope)
        
        return container
    }()
}
