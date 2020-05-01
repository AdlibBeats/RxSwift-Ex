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
    
    let userAgreementResource = Just(WKWebView.Resource.local("ABOUT_TOKENS_\("ru")"))
    let privacyPolicyResource = Just(WKWebView.Resource.network("https://google.com/"))
    let navBarTitle = Just("О приложении")
    let title = Just("КАЛЕНДАРЬ БЕРЕМЕННОСТИ")
    let description = Just("Рекомендации профессиональных врачей для каждой недели беременности")
    let tipsTitle = Just("Подсказки")
    let userAgreementTitle = Just("Пользовательское соглашение")
    let privacyPolicyTitle = Just("Политика конфиденциальности")
    let webUserAgreementTitle = Just("Польз. соглашение")
    let webPrivacyPolicyTitle = Just("Полит. конфиденциальности")
}
