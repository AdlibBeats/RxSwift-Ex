//
//  RealmBindObserver.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm

class RealmBindObserver<O: Object, Collection: RealmCollection, DataSource>: ObserverType {
    typealias BindingType = (DataSource, Collection, RealmChangeset?) -> Void
    typealias Element = (Collection, RealmChangeset?)

    let dataSource: DataSource
    let binding: BindingType

    init(dataSource: DataSource, binding: @escaping BindingType) {
        self.dataSource = dataSource
        self.binding = binding
    }

    func on(_ event: Event<Element>) {
        switch event {
        case .next(let element): binding(dataSource, element.0, element.1)
        case .error: return
        case .completed: return
        }
    }

    func asObserver() -> AnyObserver<Element> {
        AnyObserver(eventHandler: on)
    }
}
