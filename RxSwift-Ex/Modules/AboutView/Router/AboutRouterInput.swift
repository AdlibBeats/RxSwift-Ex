//
//  AboutRouterInput.swift
//  RxSwift-Ex
//
//  Created by Andrew on 17.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation
import WebKit

protocol AboutRouterInput: class {
    func presentTipsModule()
    func pushUserAgreementModule(with resource: WKWebView.Resource, title: String?)
    func pushPrivacyPolicyModule(with resource: WKWebView.Resource, title: String?)
}
