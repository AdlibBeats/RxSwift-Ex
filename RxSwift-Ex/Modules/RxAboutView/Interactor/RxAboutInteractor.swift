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
    private let entityService: EntityServiceProtocol
    private let disposeBag = DisposeBag()
    
    required init(with entityService: EntityServiceProtocol) {
        self.entityService = entityService
    }
    
    var appVersion: Observable<AppVersion> {
        entityService.fetchRXAppVersion()
    }
}
