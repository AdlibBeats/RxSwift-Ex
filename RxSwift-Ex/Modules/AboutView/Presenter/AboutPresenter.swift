//
//  AboutPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol AboutPresenterOutput: class {
    func didLoad()
    func tipsDidTap()
    func privacyPolicyDidTap()
    func userAgreementDidTap()
}

protocol AboutPresenterInput: class {
    func didSetAppVersion(_ newValue: AppVersion)
}

final class AboutPresenter {
    typealias View = AboutViewControllerProtocol
    typealias Interactor = AboutInteractorProtocol
    typealias Router = AboutRouterProtocol
    
    private weak var view: View!
    var interactor: Interactor!
    var router: Router!

    private var model = AboutModel()
    
    required init(view: View) {
        self.view = view
        
        self.view.didSetNavBarTitle(model.navBarTitle)
        self.view.didSetTitle(model.title)
        self.view.didSetDescription(model.description)
        self.view.didSetTipsTitle(model.tipsTitle)
        self.view.didSetUserAgreementTitle(model.userAgreementTitle)
        self.view.didSetPrivacyPolicyTitle(model.privacyPolicyTitle)
    }
}

extension AboutPresenter: AboutPresenterOutput {
    func didLoad() {
        interactor?.makeAppVersion()
    }
    
    func tipsDidTap() {
        router?.presentTipsModule()
    }
    
    func privacyPolicyDidTap() {
        router?.pushPrivacyPolicyModule(
            with: model.privacyPolicyResource,
            title: model.webPrivacyPolicyTitle
        )
    }
    
    func userAgreementDidTap() {
        router?.pushUserAgreementModule(
            with: model.userAgreementResource,
            title: model.webUserAgreementTitle
        )
    }
}

extension AboutPresenter: AboutPresenterInput {
    func didSetAppVersion(_ newValue: AppVersion) {
        model.appVersion = newValue
        
        view.didSetAppVersion("Версия \(model.appVersion.version)")
    }
}
