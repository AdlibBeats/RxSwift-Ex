//
//  ContactViewInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol ContactViewInput: class {
    func reload()
    func setShortName(_ newValue: String)
    func setDisplayName(_ newValue: String)
    func setActiveTime(_ newValue: String)
}
