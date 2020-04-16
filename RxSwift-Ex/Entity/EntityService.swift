//
//  EntityService.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

protocol EntityServiceProtocol: class {
    var appVersionRelay: BehaviorRelay<AppVersion?> { get }
}

final class EntityService: EntityServiceProtocol {
    enum Architecture {
        case normal
        case rx
    }
    
    enum RealmObject {
        case appVersion
    }
    
    private let realm: Realm
    private let disposedBag = DisposeBag()
    
    init(with architecture: Architecture, objects: RealmObject...) {
        do {
            realm = try Realm()
        } catch {
            fatalError("init(with objects:) has not been implemented. Error: \(error.localizedDescription)")
        }
        
        switch architecture {
        case .rx:
            objects.forEach {
                switch $0 {
                case .appVersion: rxMakeAppVersion()
                }
            }
        default: break
        }
    }
    
    let appVersionRelay = BehaviorRelay<AppVersion?>(value: nil)
    
    private func rxMakeAppVersion(version: String = "3.0.0") {
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
                let appVersion = AppVersion()
                appVersion.version = version
                appVersionRelay.accept(appVersion)
                
                Observable
                    .from(object: appVersion)
                    .asDriver(onErrorJustReturn: appVersion)
                    .drive(realm.rx.add())
                    .disposed(by: disposedBag)
            })
            .disposed(by: disposedBag)
    }
    
    func makeAppVersion(version: String = "3.0.0") -> AppVersion {
        //if realm data object not empty
        if let appVersion = realm.objects(AppVersion.self).last {
            return appVersion
        }
        
        //else create realm data (first run)
        let appVersion = AppVersion()
        appVersion.version = version
        
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
