//
//  UIBarButtonItem+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

extension UIBarButtonItem {
    /// A publisher which emits whenever this UIBarButtonItem is tapped.
    var tapPublisher: AnyPublisher<Void, Never> {
        Publishers.ControlTarget(control: self,
                                 addTargetAction: { control, target, action in
                                    control.target = target
                                    control.action = action
                                 },
                                 removeTargetAction: { control, _, _ in
                                    control?.target = nil
                                    control?.action = nil
                                 })
                  .eraseToAnyPublisher()
  }
}
