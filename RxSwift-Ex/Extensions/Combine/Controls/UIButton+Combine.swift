//
//  UIButton+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UIButton {
    /// A publisher emitting tap events from this button.
    var tapPublisher: AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: self, events: .touchUpInside)
                  .eraseToAnyPublisher()
    }
}
