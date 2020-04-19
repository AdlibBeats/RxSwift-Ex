//
//  ContactsListRouterInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol ContactsListRouterInput {
    func pushContactModule(with contact: ContactModel)
}
