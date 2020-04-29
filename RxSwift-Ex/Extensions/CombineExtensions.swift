//
//  CombineExtensions.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

extension UIViewController {
    var titleBinder: ((String?) -> Void) { { [weak self] in self?.title = $0 } }
}

extension UILabel {
    var textBinder: ((String?) -> Void) { { [weak self] in self?.text = $0 } }
}



//
//import UIKit
//import Combine
//
//final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
//    private var subscriber: SubscriberType?
//    private let control: Control
//
//    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
//        self.subscriber = subscriber
//        self.control = control
//        
//        control.addTarget(self, action: #selector(eventHandler), for: event)
//    }
//
//    func request(_ demand: Subscribers.Demand) {
//        //TODO: ...
//    }
//
//    func cancel() {
//        subscriber = nil
//    }
//
//    @objc private func eventHandler() {
//        _ = subscriber?.receive(control)
//    }
//}
//
//struct UIControlPublisher<Control: UIControl>: Publisher {
//
//    typealias Output = Control
//    typealias Failure = Never
//
//    let control: Control
//    let controlEvents: UIControl.Event
//
//    init(control: Control, events: UIControl.Event) {
//        self.control = control
//        self.controlEvents = events
//    }
//    
//    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
//        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
//        subscriber.receive(subscription: subscription)
//    }
//}
//
//protocol CombineCompatible { }
//extension UIControl: CombineCompatible { }
//extension CombineCompatible where Self: UIControl {
//    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
//        return UIControlPublisher(control: self, events: events)
//    }
//}
