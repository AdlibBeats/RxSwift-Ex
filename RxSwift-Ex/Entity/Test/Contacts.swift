//
//  Contacts.swift
//  RxSwift-Ex
//
//  Created by Andrew on 28.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

struct Contact: Codable {
    let id: Int
    let active: Bool
    let login: String
    let firstName, lastName: String?
    let displayName: String?
    let position, email: String?
    let level: String
    let businessDirID: Int
    let roles: [String]?
    let directorOfShops, shops, regions, divisions: [Int]?
    let lang: String?
    let voximplantLogin: String?

    enum CodingKeys: String, CodingKey {
        case id, active, login, firstName, lastName, displayName, position, email, level
        case businessDirID = "businessDirId"
        case roles, directorOfShops, shops, regions, divisions, lang, voximplantLogin
    }
}

typealias Contacts = [Contact]
