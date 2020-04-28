//
//  ContactInteractor.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Swinject

final class ContactInteractor {
    weak var output: ContactInteractorOutput!
}

//MARK: ContactInteractorInput
extension ContactInteractor: ContactInteractorInput {
    
}
