//
//  AboutPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import WebKit

final class AboutPresenter {
    typealias View = AboutViewInput
    typealias Interactor = AboutInteractorInput
    typealias Router = AboutRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router?
}

// MARK: AboutViewOutput
extension AboutPresenter: AboutViewOutput {
    func viewDidLoad() {
        view.setNavBarTitle("О приложении")
        view.setTitle("КАЛЕНДАРЬ БЕРЕМЕННОСТИ")
        view.setDescription("Рекомендации профессиональных врачей для каждой недели беременности")
        view.setTipsTitle("Подсказки")
        view.setUserAgreementTitle("Пользовательское соглашение")
        view.setPrivacyPolicyTitle("Политика конфиденциальности")
        
        interactor?.makeAppVersion()
    }
    
    func tipsDidTap() {
        router?.presentTipsModule()
    }
    
    func privacyPolicyDidTap() {
        router?.pushPrivacyPolicyModule(
            with: WKWebView.Resource.network("https://google.com/"),
            title: "Полит. конфиденциальности"
        )
    }
    
    func userAgreementDidTap() {
        router?.pushUserAgreementModule(
            with: WKWebView.Resource.local("ABOUT_TOKENS_\("ru")", .html),
            title: "Польз. соглашение"
        )
    }
}

// MARK: AboutInteractorOutput
extension AboutPresenter: AboutInteractorOutput {
    func didSetAppVersion(_ newValue: AppVersion) {
        view.setAppVersion("Версия \(newValue.version)")
    }
}
