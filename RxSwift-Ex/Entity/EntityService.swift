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
    func fetchAppVersion() -> Observable<AppVersion>
    
    func makeAppVersion() -> AppVersion
    func makeContacts() -> Contacts
}

final class EntityService: EntityServiceProtocol {
    private let realm: Realm
    private let disposedBag = DisposeBag()
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("init(with objects:) has not been implemented. Error: \(error.localizedDescription)")
        }
    }
    
    func fetchAppVersion() -> Observable<AppVersion> {
        Observable
            .create({ [realm] observer -> Disposable in
                //TEST Realm
                
                //if realm data object not empty
                if let appVersion = realm.objects(AppVersion.self).last {
                    observer.onNext(appVersion)
                    observer.onCompleted()
                }
                
                //else create realm data (first run)
                let appVersion = AppVersion().with { $0.version = "3.0.0" }
                do {
                    try realm.write {
                        realm.add(appVersion)
                    }
                } catch {
                    observer.onError(error)
                }
                
                observer.onNext(appVersion)
                observer.onCompleted()
                
                return Disposables.create()
            })
            .delay(.seconds(3), scheduler: MainScheduler.asyncInstance) //Will give app version after 3 seconds
            //.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)) //Realm accessed from incorrect thread.
    }
    
//    TEST
//    func fetchAppVersion() -> Observable<AppVersion> {
//        Observable.collection(from: realm.objects(AppVersion.self)).map({ [realm, disposedBag] in
//            guard let appVersion = $0.last else {
//                let appVersion = AppVersion().with { $0.version = "3.0.0" }
//                Observable.from(object: appVersion) ~> realm.rx.add() ~ disposedBag
//                return appVersion
//            }
//            return appVersion
//        })
//    }
    
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
