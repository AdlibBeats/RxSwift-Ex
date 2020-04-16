//
//  AboutRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation
import WebKit

protocol AboutRouterProtocol: class {
    func presentTipsModule()
    func pushUserAgreementModule(with resource: WKWebView.Resource, title: String?)
    func pushPrivacyPolicyModule(with resource: WKWebView.Resource, title: String?)
}

final class AboutRouter: AboutRouterProtocol {
    weak var transitionHandler: TransitionHandler?
    
    func presentTipsModule() {
        //TODO: Present Tips
    }
    
    func pushUserAgreementModule(with resource: WKWebView.Resource, title: String? = nil) {
        transitionHandler?.pushModule(
            WKWebViewController(with: resource, title: title),
            animated: true
        )
    }
    
    func pushPrivacyPolicyModule(with resource: WKWebView.Resource, title: String? = nil) {
        transitionHandler?.pushModule(
            WKWebViewController(with: resource, title: title),
            animated: true
        )
    }
}