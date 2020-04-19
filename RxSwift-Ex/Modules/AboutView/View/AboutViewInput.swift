//
//  AboutViewInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 17.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol AboutViewInput: class {
    func setNavBarTitle(_ newValue: String)
    func setTitle(_ newValue: String)
    func setDescription(_ newValue: String)
    func setTipsTitle(_ newValue: String)
    func setUserAgreementTitle(_ newValue: String)
    func setPrivacyPolicyTitle(_ newValue: String)
    func setAppVersion(_ newValue: String)
}
