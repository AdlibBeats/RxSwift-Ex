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
    func makeContacts() -> Contacts
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
    
    let appVersionRelay = BehaviorRelay<AppVersion>(
        value: AppVersion().with { $0.version = "..." }
    )
    
    private func rxMakeAppVersion() {
        let appVersionObserver = AnyObserver<Object>() { [appVersionRelay] in
            guard let appVersion = $0.element as? AppVersion else { return }
            appVersionRelay.accept(appVersion)
        }
        
        Observable
            .collection(from: realm.objects(AppVersion.self))
            .delay(.seconds(2), scheduler: MainScheduler.asyncInstance) //TEST will give app version after 2 seconds
            .map({ $0.last })
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [realm, disposedBag] in
                //TEST Realm
                
                guard let appVersion = $0 else {
                    //else create realm data (first run)
                    Observable.from(object: AppVersion().with { $0.version = "3.0.0" }) ~>
                        [realm.rx.add(), appVersionObserver] ~ disposedBag
                    return
                }
                
                //if realm data object not empty
                appVersionObserver.on(.next(appVersion))
            })
            .disposed(by: disposedBag)
    }
    
    func makeAppVersion() -> AppVersion {
        //TEST Realm
        
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
    
    func makeContacts() -> Contacts {
        //TEST Realm
        
        //if realm data object not empty
        if let contacts = realm.objects(Contacts.self).last {
            return contacts
        }
        
        //else create realm data (first run)
        let contacts = Contacts().with {
            [
                Contact().with {
                    $0.name = "Andrew"
                    $0.phone = "555 5412"
                },
                Contact().with {
                    $0.name = "Max"
                    $0.phone = "555 1196"
                },
                Contact().with {
                    $0.name = "Tod"
                    $0.phone = "555 3747"
                }
            ].forEach($0.list.append)
        }
        
        do {
            try realm.write {
                realm.add(contacts)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return contacts
    }
}
