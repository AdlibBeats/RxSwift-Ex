//
//  AboutModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.10.2019.
//  Copyright © 2019 ru.proarttherapy. All rights reserved.
//

import WebKit

struct AboutModel {
    let userAgreementResource = WKWebView.Resource.local("ABOUT_TOKENS_\("ru")", .html)
    let userAgreementTitle = "User Agreement".localized
    let privacyPolicyResource = WKWebView.Resource.network("https://google.com/")
    let privacyPolicyTitle = "Privacy Policy".localized
}
