//
//  AboutModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.10.2019.
//  Copyright © 2019 ru.proarttherapy. All rights reserved.
//

import WebKit
import RxCocoa

struct AboutModel {
    let appVersion = BehaviorRelay<AppVersion?>(value: nil)
    let userAgreementResource = BehaviorRelay<WKWebView.Resource>(value: .local("ABOUT_TOKENS_\("ru")", .html))
    let privacyPolicyResource = BehaviorRelay<WKWebView.Resource>(value: .network("https://google.com/"))
    let navBarTitle = BehaviorRelay<String>(value: "О приложении")
    let title = BehaviorRelay<String>(value: "КАЛЕНДАРЬ БЕРЕМЕННОСТИ")
    let description = BehaviorRelay<String>(value: "Рекомендации профессиональных врачей для каждой недели беременности")
    let tipsTitle = BehaviorRelay<String>(value: "Подсказки")
    let userAgreementTitle = BehaviorRelay<String>(value: "Пользовательское соглашение")
    let privacyPolicyTitle = BehaviorRelay<String>(value: "Политика конфиденциальности")
    let webUserAgreementTitle = BehaviorRelay<String>(value: "Польз. соглашение")
    let webPrivacyPolicyTitle = BehaviorRelay<String>(value: "Полит. конфиденциальности")
}
