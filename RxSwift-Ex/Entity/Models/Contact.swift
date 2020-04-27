//
//  Contact.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RealmSwift

class Contact: Object {
    @objc dynamic var id = 0
    @objc dynamic var active = false
    @objc dynamic var login = ""
    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil
    @objc dynamic var middleName: String? = nil
    @objc dynamic var position: String? = nil
    @objc dynamic var email: String? = nil
    @objc dynamic var level = ""
    let roles = List<String>()
    let divisions = List<Int>()
    let regions = List<Int>()
    let shops = List<Int>()
    let directorOfShops = List<Int>()
    @objc dynamic var businessDirId = 0
    @objc dynamic var lang: String? = nil
}
