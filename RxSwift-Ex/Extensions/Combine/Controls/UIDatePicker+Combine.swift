//
//  UIDatePicker+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UIDatePicker {
    /// A publisher emitting date changes from this date picker.
    var datePublisher: AnyPublisher<Date, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.date)
                  .eraseToAnyPublisher()
    }
    
    /// A publisher emitting countdown duration changes from this date picker.
    var countDownDurationPublisher: AnyPublisher<TimeInterval, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.countDownDuration)
                  .eraseToAnyPublisher()
    }
}
