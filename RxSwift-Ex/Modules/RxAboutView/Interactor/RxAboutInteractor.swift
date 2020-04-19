//
//  RxAboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa
import Swinject

protocol RxAboutInteractorProtocol: class {
    var appVersion: Observable<AppVersion> { get }
}

final class RxAboutInteractor: RxAboutInteractorProtocol {
    private let container: Container
    private let disposeBag = DisposeBag()
    
    required init(container: Container) {
        self.container = container
    }
    
    var appVersion: Observable<AppVersion> {
        let entityService = container.resolve(EntityServiceProtocol.self)!
        return entityService.fetchAppVersion() //.observeOn(MainScheduler.instance) //Realm accessed from incorrect thread.
    }
}
