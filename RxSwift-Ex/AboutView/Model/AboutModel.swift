//
//  AboutModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.10.2019.
//  Copyright © 2019 ru.proarttherapy. All rights reserved.
//

import WebKit

struct AboutModel {
    var appVersion = ""
    
    let userAgreementResource = WKWebView.Resource.local("ABOUT_TOKENS_\("ru")", .html)
    let privacyPolicyResource = WKWebView.Resource.network("https://google.com/")
    
    let navBarTitle = "О приложении"
    let title = "КАЛЕНДАРЬ БЕРЕМЕННОСТИ"
    
    let description = "Рекомендации  профессиональных врачей для каждой недели беременности"
    
    let tipsTitle = "Подсказки"
    let userAgreementTitle = "Пользовательское соглашение"
    let privacyPolicyTitle = "Политика конфиденциальности"
    
    let webUserAgreementTitle = "Польз. соглашение"
    let webPrivacyPolicyTitle = "Полит. конфиденциальности"
}
