//
//  AboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol AboutInteractorInput: class {
    func makeAppVersion()
}

protocol AboutInteractorOutput: class {
    func didSetAppVersion(_ newValue: AppVersion)
}

final class AboutInteractor {
    typealias Presenter = AboutInteractorOutput
    
    private weak var presenter: Presenter!
    
    private let entityService: EntityServiceProtocol = EntityService()
    
    required init(presenter: Presenter) {
        self.presenter = presenter
    }
}

//MARK: AboutInteractorInput
extension AboutInteractor: AboutInteractorInput {
    func makeAppVersion() {
        presenter.didSetAppVersion(entityService.makeAppVersion())
    }
}
