//
//  UIGestureRecognizer+Combine.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import UIKit

// MARK: - Gesture Publishers

extension UITapGestureRecognizer {
    /// A publisher which emits when this Tap Gesture Recognizer is triggered
    var tapPublisher: AnyPublisher<UITapGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
    
    var easyTapPublisher: AnyPublisher<Void, Never> {
        gesturePublisher(for: self)
    }
}

extension UIPinchGestureRecognizer {
    /// A publisher which emits when this Pinch Gesture Recognizer is triggered
    var pinchPublisher: AnyPublisher<UIPinchGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

extension UIRotationGestureRecognizer {
    /// A publisher which emits when this Rotation Gesture Recognizer is triggered
    var rotationPublisher: AnyPublisher<UIRotationGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

extension UISwipeGestureRecognizer {
    /// A publisher which emits when this Swipe Gesture Recognizer is triggered
    var swipePublisher: AnyPublisher<UISwipeGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

extension UIPanGestureRecognizer {
    /// A publisher which emits when this Pan Gesture Recognizer is triggered
    var panPublisher: AnyPublisher<UIPanGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

extension UIScreenEdgePanGestureRecognizer {
    /// A publisher which emits when this Screen Edge Gesture Recognizer is triggered
    var screenEdgePanPublisher: AnyPublisher<UIScreenEdgePanGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

extension UILongPressGestureRecognizer {
    /// A publisher which emits when this Long Press Recognizer is triggered
    var longPressPublisher: AnyPublisher<UILongPressGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

// MARK: - Private Helpers

// A private generic helper function which returns the provided
// generic publisher whenever its specific event occurs.
private func gesturePublisher<Gesture: UIGestureRecognizer>(for gesture: Gesture) -> AnyPublisher<Gesture, Never> {
    Publishers.ControlTarget(control: gesture,
                             addTargetAction: { gesture, target, action in
                                gesture.addTarget(target, action: action)
                             },
                             removeTargetAction: { gesture, target, action in
                                gesture?.removeTarget(target, action: action)
                             })
              .map { gesture }
        .eraseToAnyPublisher()
}

private func gesturePublisher<Gesture: UIGestureRecognizer>(for gesture: Gesture) -> AnyPublisher<Void, Never> {
    Publishers.ControlTarget(control: gesture,
                             addTargetAction: { gesture, target, action in
                                gesture.addTarget(target, action: action)
                             },
                             removeTargetAction: { gesture, target, action in
                                gesture?.removeTarget(target, action: action)
                             })
        .eraseToAnyPublisher()
}
