//
//  FiltersInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

final class FiltersListInteractor {
    weak var output: FiltersListInteractorOutput!
}

//MARK: ContactsListInteractorInput
extension FiltersListInteractor: FiltersListInteractorInput {
    func makeFilters() {
        output.setFilters([
            .init(title: "Уровень"),
            .init(title: "Бизнес-направление"),
            .init(title: "Дивизион"),
            .init(title: "Регион"),
            .init(title: "Магазин")
        ])
    }
}
