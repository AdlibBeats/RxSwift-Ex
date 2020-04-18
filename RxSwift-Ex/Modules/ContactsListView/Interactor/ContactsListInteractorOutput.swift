//
//  ContactsListInteractorOutput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol ContactsListInteractorOutput: class {
    func didSetContacts(_ contacts: [ContactPresenter])
}
