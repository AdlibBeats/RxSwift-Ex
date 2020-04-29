//
//  FiltersListAssembly.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

typealias FiltersListModule = BaseModule<FiltersListModuleInput, FiltersListModuleOutput>

extension Assembly {
    static func createModule(_ module: FiltersListModule.Type, output: FiltersListModuleOutput?) -> FiltersListModule {
        let storyboard = UIStoryboard(name: "FiltersListView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FiltersListViewController")
        let filtersListViewController = viewController as! FiltersListViewController
        let presenter = FiltersListPresenter()
        let interactor = FiltersListInteractor()
        let router = FiltersListRouter()
        
        presenter.view = filtersListViewController
        filtersListViewController.output = presenter
        router.transitionHandler = filtersListViewController
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.router = router
        
        return FiltersListModule(view: filtersListViewController, input: presenter, output: output)
    }
}
