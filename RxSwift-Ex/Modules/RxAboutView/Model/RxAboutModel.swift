//
//  RxAboutModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import WebKit
import RxCocoa
import RxSwift

struct RxAboutModel {
    let appVersion = BehaviorRelay<AppVersion>(value: AppVersion().with { $0.version = "..." })
    
    let userAgreementResource = Observable.just(WKWebView.Resource.local("ABOUT_TOKENS_\("ru")"))
    let privacyPolicyResource = Observable.just(WKWebView.Resource.network("https://google.com/"))
    let navBarTitle = Observable.just("О приложении")
    let title = Observable.just("КАЛЕНДАРЬ БЕРЕМЕННОСТИ")
    let description = Observable.just("Рекомендации профессиональных врачей для каждой недели беременности")
    let tipsTitle = Observable.just("Подсказки")
    let userAgreementTitle = Observable.just("Пользовательское соглашение")
    let privacyPolicyTitle = Observable.just("Политика конфиденциальности")
    let webUserAgreementTitle = Observable.just("Польз. соглашение")
    let webPrivacyPolicyTitle = Observable.just("Полит. конфиденциальности")
}
