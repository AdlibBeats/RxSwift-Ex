//
//  AboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AboutInteractorProtocol: class {
    var appVersionRelay: BehaviorRelay<AppVersion?> { get }
}

class AboutInteractor: AboutInteractorProtocol {
    weak var presenter: AboutPresenterProtocol!
    let entityService: EntityServiceProtocol = EntityService(with: .appVersion)
    let disposeBag = DisposeBag()
    let appVersionRelay = BehaviorRelay<AppVersion?>(value: nil)
    
    required init(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
        
        entityService.appVersionRelay
            .asDriver()
            .drive(appVersionRelay)
            .disposed(by: disposeBag)
    }
}
