//
//  ContactModuleInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol ContactModuleInput: class {
    func didSetContact(_ newValue: ContactModel)
}