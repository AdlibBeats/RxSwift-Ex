//
//  UISwitch+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UISwitch {
    /// A publisher emitting on status changes for this switch.
    var isOnPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.isOn)
                  .eraseToAnyPublisher()
    }
}
