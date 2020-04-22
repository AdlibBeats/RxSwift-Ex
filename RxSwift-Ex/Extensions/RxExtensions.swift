//
//  RxExtensions.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

#if os(iOS)

import RxSwift
import RxCocoa
import WebKit
import RealmSwift

extension Reactive where Base : UIViewController {
    var present: Binder<UIViewController?> {
        Binder(base) { viewController, value in
            value.flatMap {
                viewController.present($0, animated: true)
            }
        }
    }
}

extension Reactive where Base : UINavigationController {
    var push: Binder<UIViewController?> {
        Binder(base) { navigationController, value in
            value.flatMap {
                navigationController.pushViewController($0, animated: true)
            }
        }
    }
}

extension Reactive where Base : UITextField {
    var textColor: Binder<UIColor?> {
        Binder(base) { textField, color in
            textField.textColor = color
        }
    }
    
    var becomeFirstResponder: Binder<Void> {
        Binder(base) { textField, _ in
            textField.becomeFirstResponder()
        }
    }
    
    var resignFirstResponder: Binder<Void> {
        Binder(base) { textField, _ in
            textField.resignFirstResponder()
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
    var date: Binder<Date> {
        Binder(base) { datePicker, date in
            datePicker.setDate(date, animated: false)
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
    
//    var tap: Observable<Void> {
//        tapGesture().when(.recognized).map { _ in }
//    }
}

extension Reactive where Base : UIViewController {
    var title: Binder<String> {
        Binder(base) { viewController, value in
            viewController.title = value
        }
    }
}

extension Reactive where Base : WKWebView {
    var load: Binder<WKWebView.Resource> {
        Binder(base) { webView, value in
            do {
                webView.load(try WKWebView.makeRequest(value))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension Reactive where Base : UITableView {
    func realmChanges<E>(_ dataSource: RxTableViewRealmDataSource<E>) -> RealmBindObserver<E, AnyRealmCollection<E>, RxTableViewRealmDataSource<E>> {
        RealmBindObserver(dataSource: dataSource) { dataSource, results, changes in
            if dataSource.tableView == nil {
                dataSource.tableView = self.base
            }
            dataSource.tableView?.dataSource = dataSource
            dataSource.applyChanges(items: AnyRealmCollection<E>(results), changes: changes)
        }
    }
    
    func realmModelSelected<E>(_ modelType: E.Type) -> ControlEvent<E> where E: Object {
        ControlEvent(
            events: itemSelected.flatMap { [weak view = self.base as UITableView] indexPath -> Observable<E> in
                guard
                    let view = view,
                    let dataSource = view.dataSource as? RxTableViewRealmDataSource<E> else {
                        return Observable.empty()
                }
                return Observable.just(dataSource.model(at: indexPath))
            }
        )
    }
}

extension Reactive where Base : UICollectionView {
    func realmChanges<E>(_ dataSource: RxCollectionViewRealmDataSource<E>) -> RealmBindObserver<E, AnyRealmCollection<E>, RxCollectionViewRealmDataSource<E>> {
        RealmBindObserver(dataSource: dataSource) { dataSource, results, changes in
            if dataSource.collectionView == nil {
                dataSource.collectionView = self.base
            }
            dataSource.collectionView?.dataSource = dataSource
            dataSource.applyChanges(items: AnyRealmCollection<E>(results), changes: changes)
        }
    }

    func realmModelSelected<E>(_ modelType: E.Type) -> ControlEvent<E> where E: Object {
        ControlEvent(
            events: itemSelected.flatMap { [weak view = base as UICollectionView] indexPath -> Observable<E> in
                guard
                    let view = view,
                    let dataSource = view.dataSource as? RxCollectionViewRealmDataSource<E> else {
                        return Observable.empty()
                }
                return Observable.just(dataSource.model(at: indexPath))
            }
        )
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
