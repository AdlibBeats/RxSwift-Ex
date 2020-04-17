//
//  EntityService.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxBinding
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

protocol EntityServiceProtocol: class {
    var appVersionRelay: BehaviorRelay<AppVersion> { get }
    func makeAppVersion() -> AppVersion
}

final class EntityService: EntityServiceProtocol {
    enum RealmObject {
        case appVersion
    }
    
    private let realm: Realm
    private let disposedBag = DisposeBag()
    
    init(with objects: RealmObject...) {
        do {
            realm = try Realm()
        } catch {
            fatalError("init(with objects:) has not been implemented. Error: \(error.localizedDescription)")
        }
        
        objects.forEach {
            switch $0 {
            case .appVersion: rxMakeAppVersion()
            }
        }
    }
    
    let appVersionRelay = BehaviorRelay<AppVersion>(value: .init())
    
    private func rxMakeAppVersion(appVersion: AppVersion = AppVersion().with { $0.version = "3.0.0" }) {
        Observable
            .collection(from: realm.objects(AppVersion.self))
            .map({ $0.last })
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [realm, appVersionRelay, disposedBag] in
                //TEST Realm
                
                //if realm data object not empty
                if let appVersion = $0 {
                    appVersionRelay.accept(appVersion)
                    return
                }
                
                //else create realm data (first run)
                Observable.from(object: appVersion) ~> realm.rx.add() ~
                Observable.from(object: appVersion) ~> appVersionRelay ~ disposedBag
            })
            .disposed(by: disposedBag)
    }
    
    func makeAppVersion() -> AppVersion {
        //if realm data object not empty
        if let appVersion = realm.objects(AppVersion.self).last {
            return appVersion
        }
        
        //else create realm data (first run)
        let appVersion = AppVersion().with { $0.version = "3.0.0" }
        do {
            try realm.write {
                realm.add(appVersion)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return appVersion
    }
}
