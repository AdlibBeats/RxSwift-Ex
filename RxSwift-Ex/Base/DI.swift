//
//  DI.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import Then

enum ContainerError: Error {
    case unwrapped
}

extension ObjectScope {
    static let servicesScope = ObjectScope(storageFactory: PermanentStorage.init)
}

// MARK: Then
extension Container: Then { }

enum Module: String {
    case rxAbout
    case combineAbout
    case test
}

extension Container {
    static let shared = Container().with {
        
        /* register services */
        $0.register(EntityServiceProtocol.self, factory: { _ in EntityService() })
        
        $0.register(TestViewModel.self, factory: { _ in TestViewModel(/* inject services */) })
        $0.register(UIViewController.self, name: Module.test.rawValue, factory: { resolver in
            TestViewController(viewModel: resolver.resolve(TestViewModel.self)!)
        }).inObjectScope(.container)
        
        $0.register(UINavigationController.self, name: Module.rxAbout.rawValue, factory: { _ in UINavigationController() })
        $0.register(RxAboutViewController.self, factory: { r in
                let viewController = RxAboutViewController()
                let presenter = RxAboutPresenter()
                viewController.presenter = presenter
                r.resolve(EntityServiceProtocol.self).flatMap {
                    presenter.interactor = RxAboutInteractor(with: $0)
                }
                presenter.router = RxAboutRouter()
                return viewController
        }).inObjectScope(.container)
        
        $0.register(UINavigationController.self, name: Module.combineAbout.rawValue, factory: { _ in UINavigationController() })
        $0.register(CombineAboutViewController.self, factory: { r in
                let viewController = CombineAboutViewController()
                let presenter = CombineAboutPresenter()
                viewController.presenter = presenter
                r.resolve(EntityServiceProtocol.self).flatMap {
                    presenter.interactor = CombineAboutInteractor(with: $0)
                }
                presenter.router = CombineAboutRouter()
                return viewController
        }).inObjectScope(.container)
    }
    
    private func localResolve<Service>(_ serviceType: Service.Type) throws -> Service {
        guard let resolver = resolve(serviceType) else { throw ContainerError.unwrapped }
        return resolver
    }
    
    private func localResolve<Service>(_ serviceType: Service.Type, name: String) throws -> Service {
        guard let resolver = resolve(serviceType, name: name) else { throw ContainerError.unwrapped }
        return resolver
    }
    
    private func resolve<Service>(_ serviceType: Service.Type, module: Module) throws -> Service {
        guard let resolver = resolve(serviceType, name: module.rawValue) else { throw ContainerError.unwrapped }
        return resolver
    }
    
    func resolveViewController(module: Module) -> UIViewController? {
        try? resolve(UIViewController.self, module: module)
    }
    
    func resolveNavigationController(module: Module) -> UINavigationController? {
        try? resolve(UINavigationController.self, module: module)
    }
}
