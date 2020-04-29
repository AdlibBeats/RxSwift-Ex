//
//  UIRefreshControl+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UIRefreshControl {
    /// A publisher emitting refresh status changes from this refresh control.
    var isRefreshingPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.isRefreshing)
                  .eraseToAnyPublisher()
    }
}
