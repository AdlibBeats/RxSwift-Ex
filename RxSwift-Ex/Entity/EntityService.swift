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
import Combine

enum EntityServiceError: Error {
    case invalidObjects
}

protocol EntityServiceProtocol: class {
    func fetchRXAppVersion() -> Observable<AppVersion>
    func fetchCombineAppVersion() -> AnyPublisher<AppVersion, Never>
    
    func makeAppVersion() -> AppVersion
    func makeContacts() throws -> Contacts
}

final class EntityService: EntityServiceProtocol {
    private let realm: Realm
    private let disposeBag = DisposeBag()
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("init(with objects:) has not been implemented. Error: \(error.localizedDescription)")
        }
    }
    
    func fetchCombineAppVersion() -> AnyPublisher<AppVersion, Never> {
        Just(makeAppVersion())
            .delay(for: .seconds(3), scheduler: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchRXAppVersion() -> Observable<AppVersion> {
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
            .delay(.seconds(3), scheduler: MainScheduler.asyncInstance)
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
    
    func makeContacts() throws -> Contacts {
        guard let path = Bundle.main.path(forResource: "contacts", ofType: ".json") else {
            throw EntityServiceError.invalidObjects
        }
        return try jsonDecoder.decode(Contacts.self, from: try Data(contentsOf: URL(fileURLWithPath: path)))
    }
    
    private let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        return jsonEncoder
    }()
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}
