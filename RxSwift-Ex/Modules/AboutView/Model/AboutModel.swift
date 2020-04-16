//
//  AboutModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import WebKit

struct AboutModel {
    var appVersion = AppVersion()
    let userAgreementResource = WKWebView.Resource.local("ABOUT_TOKENS_\("ru")", .html)
    let privacyPolicyResource = WKWebView.Resource.network("https://google.com/")
    let navBarTitle = "О приложении"
    let title = "КАЛЕНДАРЬ БЕРЕМЕННОСТИ"
    let description = "Рекомендации профессиональных врачей для каждой недели беременности"
    let tipsTitle = "Подсказки"
    let userAgreementTitle = "Пользовательское соглашение"
    let privacyPolicyTitle = "Политика конфиденциальности"
    let webUserAgreementTitle = "Польз. соглашение"
    let webPrivacyPolicyTitle = "Полит. конфиденциальности"
}
