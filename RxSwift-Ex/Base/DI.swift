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
    static let viewControllersScope = ObjectScope(storageFactory: PermanentStorage.init)
}

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container
            .register(EntityServiceProtocol.self, factory: { _ in EntityService() })
            .inObjectScope(.servicesScope)
        
        container
            .register(UINavigationController.self, name: "RxAboutNavigationView", factory: { _ in UINavigationController() })
            .inObjectScope(.viewControllersScope)
        
        container
            .register(RxAboutViewController.self, factory: { r in
                let viewController = RxAboutViewController()
                let presenter = RxAboutPresenter()
                viewController.presenter = presenter
                r.resolve(EntityServiceProtocol.self).flatMap {
                    presenter.interactor = RxAboutInteractor(with: $0)
                }
                presenter.router = RxAboutRouter()
                return viewController
            })
            .inObjectScope(.viewControllersScope)
        
        container
            .register(UINavigationController.self, name: "CombineAboutNavigationView", factory: { _ in UINavigationController() })
            .inObjectScope(.viewControllersScope)
        
        container
            .register(CombineAboutViewController.self, factory: { r in
                let viewController = CombineAboutViewController()
                let presenter = CombineAboutPresenter()
                viewController.presenter = presenter
                r.resolve(EntityServiceProtocol.self).flatMap {
                    presenter.interactor = CombineAboutInteractor(with: $0)
                }
                presenter.router = CombineAboutRouter()
                return viewController
            })
            .inObjectScope(.viewControllersScope)
        
        return container
    }()
}
