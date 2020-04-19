//
//  AboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

final class AboutInteractor {
    typealias Presenter = AboutInteractorOutput
    
    private weak var presenter: Presenter!
    
    private let container: Container
    
    required init(with presenter: Presenter, container: Container) {
        self.presenter = presenter
        self.container = container
    }
}

//MARK: AboutInteractorInput
extension AboutInteractor: AboutInteractorInput {
    func makeAppVersion() {
        let entityService = container.resolve(EntityServiceProtocol.self)!
        presenter.didSetAppVersion(entityService.makeAppVersion())
    }
}
