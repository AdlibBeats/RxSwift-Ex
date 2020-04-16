//
//  RxExtension.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

#if os(iOS) || os(tvOS)

import RxSwift
import RxCocoa

extension Reactive where Base : UITextField {
    var textColor: Binder<UIColor?> {
        Binder(base) { textField, color in
            textField.textColor = color
        }
    }
}

extension Reactive where Base : UILabel {
    var textColor: Binder<UIColor?> {
        Binder(base) { label, color in
            label.textColor = color
        }
    }
}

extension Reactive where Base : UIDatePicker {
    var date: Binder<Date?> {
        Binder(base) { datePicker, date in
            datePicker.setDate(date ?? .init(), animated: false)
        }
    }
    
    var minimumDate: Binder<Date?> {
        Binder(base) { datePicker, date in
            datePicker.minimumDate = date
        }
    }
    
    var maximumDate: Binder<Date?> {
        Binder(base) { datePicker, date in
            datePicker.maximumDate = date
        }
    }
}

extension Reactive where Base : UIView {
    var endEditing: Binder<Bool> {
        Binder(base) { view, value in
            view.endEditing(value)
        }
    }
}

extension Reactive where Base : UIViewController {
    var title: Binder<String> {
        Binder(base) { viewController, value in
            viewController.title = value
        }
    }
}

extension Array where Element == Disposable {
    func elementsDisposed(by disposeBag: DisposeBag) {
        forEach { $0.disposed(by: disposeBag) }
    }
}

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    func drive(_ relays: BehaviorRelay<Element>...) -> [Disposable] {
        relays.map { drive($0) }
    }

    func drive(_ relays: BehaviorRelay<Element?>...) -> [Disposable] {
        relays.map { drive($0) }
    }
    
    func drive<Observer: ObserverType>(_ observers: Observer...) -> [Disposable] where Observer.Element == Element {
        observers.map { drive($0) }
    }
    
    func drive<Observer: ObserverType>(_ observers: Observer...) -> [Disposable] where Observer.Element == Element? {
        observers.map { drive($0) }
    }
}

#endif
