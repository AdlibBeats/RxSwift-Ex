//
//  AboutInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

final class AboutInteractor {
    weak var output: AboutInteractorOutput!
}

//MARK: AboutInteractorInput
extension AboutInteractor: AboutInteractorInput {
    func makeAppVersion() {
        let entityService = Container.shared.resolve(EntityServiceProtocol.self)!
        output.didSetAppVersion(entityService.makeAppVersion())
    }
}
