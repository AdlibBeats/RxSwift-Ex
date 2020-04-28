//
//  ContactPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 19.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

struct ContactProperty {
    let title: String
    let value: String
}

typealias ContactProperties = [ContactProperty]

final class ContactPresenter {
    typealias View = ContactViewInput
    typealias Interactor = ContactInteractorInput
    typealias Router = ContactRouterInput
    typealias Output = ContactModuleOutput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router?
    var output: Output?
    
    private var properties: ContactProperties = []
    
    private var contact: Contact! {
        willSet {
            if let email = newValue?.email {
                properties.append(.init(title: "E-mail", value: email))
            }
            
            if let login = newValue?.login {
                properties.append(.init(title: "Логин", value: login))
            }
            
            if let position = newValue?.position {
                properties.append(.init(title: "Должность", value: position))
            }
            
            if let level = newValue?.level {
                properties.append(.init(title: "Уровень", value: level))
            }
        }
    }
}

//MARK: ContactViewOutput
extension ContactPresenter: ContactViewOutput {
    func messagesDidTap() {
        //TODO:
        print(#function)
    }
    
    func menuDidTap() {
        //TODO:
        print(#function)
    }
    
    var propertiesList: ContactProperties { properties }
    
    func viewDidLoad() {
        view.setShortName("\(contact?.lastName?[0] ?? "") \(contact?.firstName?[0] ?? "")")
        view.setDisplayName(contact?.displayName ?? "")
        view.setActiveTime((contact?.active ?? false) ? "В сети" : "Не в сети")
        
        view.reload()
    }
}

//MARK: ContactInteractorOutput
extension ContactPresenter: ContactInteractorOutput {
    
}

//MARK: ContactModuleInput
extension ContactPresenter: ContactModuleInput {
    func setContact(_ newValue: Contact) {
        contact = newValue
    }
}

private extension String {
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
