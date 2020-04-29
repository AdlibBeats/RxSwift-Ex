//
//  FiltersListPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

struct Filter {
    let title: String
}

typealias Filters = [Filter]

final class FiltersListPresenter {
    typealias View = FiltersListViewInput
    typealias Interactor = FiltersListInteractorInput
    typealias Router = FiltersListRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router?
    
    private var filters: Filters = [] {
        willSet {
            view?.reload()
        }
    }
}

//MARK: FiltersListViewOutput
extension FiltersListPresenter: FiltersListViewOutput {
    var filtersList: Filters { filters }
    
    func viewDidLoad() {
        interactor?.makeFilters()
    }
    
    func tableViewDidSelect(_ index: Int) {
        //router?.goToContactModule(with: filtersList[index])
    }
}

//MARK: FiltersListInteractorOutput
extension FiltersListPresenter: FiltersListInteractorOutput {
    func setFilters(_ filters: Filters) {
        self.filters = filters
    }
}

//MARK: FiltersListModuleInput
extension FiltersListPresenter: FiltersListModuleInput {
    
}
