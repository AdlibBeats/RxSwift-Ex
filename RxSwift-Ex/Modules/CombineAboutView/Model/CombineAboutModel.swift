//
//  CombineAboutModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import WebKit
import Combine

struct CombineAboutModel {
    let appVersion = CurrentValueSubject<AppVersion, Never>(AppVersion().with { $0.version = "..." })
    let userAgreementResource = CurrentValueSubject<WKWebView.Resource, Never>(.local("ABOUT_TOKENS_\("ru")"))
    let privacyPolicyResource = CurrentValueSubject<WKWebView.Resource, Never>(.network("https://google.com/"))
    let navBarTitle = CurrentValueSubject<String, Never>("О приложении")
    let title = CurrentValueSubject<String, Never>("КАЛЕНДАРЬ БЕРЕМЕННОСТИ")
    let description = CurrentValueSubject<String, Never>("Рекомендации профессиональных врачей для каждой недели беременности")
    let tipsTitle = CurrentValueSubject<String, Never>("Подсказки")
    let userAgreementTitle = CurrentValueSubject<String, Never>("Пользовательское соглашение")
    let privacyPolicyTitle = CurrentValueSubject<String, Never>("Политика конфиденциальности")
    let webUserAgreementTitle = CurrentValueSubject<String, Never>("Польз. соглашение")
    let webPrivacyPolicyTitle = CurrentValueSubject<String, Never>("Полит. конфиденциальности")
}
