//
//  RxAboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa

protocol RxAboutInteractorProtocol: class {
    var appVersionRelay: BehaviorRelay<AppVersion?> { get }
}

final class RxAboutInteractor: RxAboutInteractorProtocol {
    typealias Presenter = RxAboutPresenterProtocol
    
    private weak var presenter: Presenter!
    
    private let entityService: EntityServiceProtocol = EntityService(with: .rx, objects: .appVersion)
    private let disposeBag = DisposeBag()
    
    required init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    var appVersionRelay: BehaviorRelay<AppVersion?> {
        entityService.appVersionRelay
    }
}
