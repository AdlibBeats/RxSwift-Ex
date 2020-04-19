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
    typealias Presenter = RxAboutPresenterProtocol
    
    private weak var presenter: Presenter!
    
    private let container: Container
    private let disposeBag = DisposeBag()
    
    required init(presenter: Presenter, container: Container) {
        self.presenter = presenter
        self.container = container
    }
    
    var appVersion: Observable<AppVersion> {
        let entityService = container.resolve(EntityServiceProtocol.self)!
        return entityService.fetchAppVersion() //.observeOn(MainScheduler.instance) //Realm accessed from incorrect thread.
    }
}
