//
//  DI.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

extension ObjectScope {
    static let custom = ObjectScope(storageFactory: PermanentStorage.init)
}

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container
            .register(EntityServiceProtocol.self, factory: { _ in EntityService() })
            .inObjectScope(.custom)
        
        return container
    }()
    
    func reset() {
        resetObjectScope(.custom)
    }
}
