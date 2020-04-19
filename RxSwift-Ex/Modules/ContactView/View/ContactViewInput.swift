//
//  ContactViewInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol ContactViewInput: class {
    func setNavBarTitle(_ newValue: String)
    func setName(_ newValue: String)
    func setPhone(_ newValue: String)
}
