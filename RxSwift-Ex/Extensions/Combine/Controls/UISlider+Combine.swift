//
//  UISlider+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UISlider {
    /// A publisher emitting value changes for this slider.
    var valuePublisher: AnyPublisher<Float, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.value)
                  .eraseToAnyPublisher()
    }
}
