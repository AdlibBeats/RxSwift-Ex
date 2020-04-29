//
//  UISegmentedControl+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UISegmentedControl {
    /// A publisher emitting selected segment index changes for this segmented control.
    var selectedSegmentIndexPublisher: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.selectedSegmentIndex)
                  .eraseToAnyPublisher()
    }
}
