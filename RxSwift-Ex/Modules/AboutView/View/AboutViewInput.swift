//
//  AboutViewInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 17.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol AboutViewInput: class {
    func didSetNavBarTitle(_ newValue: String)
    func didSetTitle(_ newValue: String)
    func didSetDescription(_ newValue: String)
    func didSetTipsTitle(_ newValue: String)
    func didSetUserAgreementTitle(_ newValue: String)
    func didSetPrivacyPolicyTitle(_ newValue: String)
    func didSetAppVersion(_ newValue: String)
}
