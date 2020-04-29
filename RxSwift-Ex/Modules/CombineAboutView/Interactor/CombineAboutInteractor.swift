//
//  CombineAboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

protocol CombineAboutInteractorProtocol: class {
    var appVersion: AppVersion { get }
}

final class CombineAboutInteractor: CombineAboutInteractorProtocol {
    private let entityService: EntityServiceProtocol
    
    required init(with entityService: EntityServiceProtocol) {
        self.entityService = entityService
    }
    
    var appVersion: AppVersion {
        entityService.makeAppVersion() //.observeOn(MainScheduler.instance) //Realm accessed from incorrect thread.
    }
}
