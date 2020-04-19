//
//  ContactViewInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol ContactViewInput: class {
    func didSetNavBarTitle(_ newValue: String)
    func didSetName(_ newValue: String)
    func didSetPhone(_ newValue: String)
}
