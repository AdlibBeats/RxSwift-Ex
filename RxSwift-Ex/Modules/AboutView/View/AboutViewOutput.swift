//
//  AboutViewOutput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 17.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol AboutViewOutput: class {
    func didLoad()
    func tipsDidTap()
    func privacyPolicyDidTap()
    func userAgreementDidTap()
}
