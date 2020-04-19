//
//  ContactInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

final class ContactInteractor {
    typealias Presenter = ContactInteractorOutput
    
    private weak var presenter: Presenter!
    
    required init(with presenter: Presenter) {
        self.presenter = presenter
    }
}

extension ContactInteractor: ContactInteractorInput {
    
}
