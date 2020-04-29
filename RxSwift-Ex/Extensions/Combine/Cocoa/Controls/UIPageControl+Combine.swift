//
//  UIPageControl+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UIPageControl {
    /// A publisher emitting current page changes for this page control.
    var currentPagePublisher: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.currentPage)
                  .eraseToAnyPublisher()
    }
}
