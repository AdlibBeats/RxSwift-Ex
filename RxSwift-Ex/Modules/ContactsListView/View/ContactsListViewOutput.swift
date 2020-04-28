//
//  ContactsListViewOutput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol ContactsListViewOutput: class {
    var contactsList: Contacts { get }
    
    func viewDidLoad()
    func tableViewDidSelect(_ index: Int)
    func filterDidTap()
    func searchDidTap()
    func videoCallDidTap(_ contact: Contact)
    func audioCallDidTap(_ contact: Contact)
}
