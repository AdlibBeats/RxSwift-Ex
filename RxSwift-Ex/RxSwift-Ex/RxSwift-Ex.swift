//
//  RxSwift-Ex.swift
//  RxSwift-Ex
//
//  Created by Andrew on 10.02.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base : UIViewController {
    var present: Binder<UIViewController?> {
        Binder(self.base) { viewController, value in
            guard let source = value else { return }
            viewController.present(source, animated: true)
        }
    }
}

extension Reactive where Base : UINavigationController {
    var pushViewController: Binder<UIViewController?> {
        Binder(self.base) { navigationController, value in
            guard let source = value else { return }
            navigationController.pushViewController(source, animated: true)
        }
    }
}

extension Reactive where Base : UITextField {
    var textColor: Binder<UIColor?> {
        Binder(self.base) { textField, color in
            textField.textColor = color
        }
    }
}

extension Reactive where Base : UILabel {
    var textColor: Binder<UIColor?> {
        Binder(self.base) { label, color in
            label.textColor = color
        }
    }
}

extension Reactive where Base : UIDatePicker {
    var date: Binder<Date?> {
        Binder(self.base) { datePicker, date in
            datePicker.setDate(date ?? .init(), animated: false)
        }
    }
    
    var minimumDate: Binder<Date?> {
        Binder(self.base) { datePicker, date in
            datePicker.minimumDate = date
        }
    }
    
    var maximumDate: Binder<Date?> {
        Binder(self.base) { datePicker, date in
            datePicker.maximumDate = date
        }
    }
}

extension Reactive where Base : UIView {
    var endEditing: Binder<Bool> {
        Binder(self.base) { view, value in
            view.endEditing(value)
        }
    }
}

extension Array where Element == Disposable {
    func disposed(by disposeBag: DisposeBag) {
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
