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
    
    private weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    required init(with view: View) {
        self.view = view
    }
}

// MARK: AboutViewOutput
extension AboutPresenter: AboutViewOutput {
    func didLoad() {
        view.didSetNavBarTitle("О приложении")
        view.didSetTitle("КАЛЕНДАРЬ БЕРЕМЕННОСТИ")
        view.didSetDescription("Рекомендации профессиональных врачей для каждой недели беременности")
        view.didSetTipsTitle("Подсказки")
        view.didSetUserAgreementTitle("Пользовательское соглашение")
        view.didSetPrivacyPolicyTitle("Политика конфиденциальности")
        
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
        view.didSetAppVersion("Версия \(newValue.version)")
    }
}
