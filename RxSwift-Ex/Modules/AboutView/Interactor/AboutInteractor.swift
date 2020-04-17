//
//  AboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol AboutInteractorProtocol: class {
    func makeAppVersion()
}

final class AboutInteractor {
    typealias Presenter = AboutPresenterInput
    
    private weak var presenter: Presenter!
    
    private let entityService: EntityServiceProtocol = EntityService()
    
    required init(presenter: Presenter) {
        self.presenter = presenter
    }
}

extension AboutInteractor: AboutInteractorProtocol {
    func makeAppVersion() {
        presenter.didSetAppVersion(entityService.makeAppVersion())
    }
}
