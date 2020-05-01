//
//  CombineAboutPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import WebKit

protocol CombineAboutPresenterProtocol: class {
    typealias Input = CombineAboutPresenter.Input
    typealias Output = CombineAboutPresenter.Output
    
    func transform(input: Input) -> Output
}

final class CombineAboutPresenter: CombineAboutPresenterProtocol {
    typealias Router = CombineAboutRouterProtocol
    typealias Interactor = CombineAboutInteractorProtocol
    
    private var model = CombineAboutModel()
    private var subscriptions = Set<AnyCancellable>()
    
    var router: Router!
    var interactor: Interactor!
    
    func transform(input: Input) -> Output {
        interactor.appVersion ~> model.appVersion ~
        input.tipsTapEvent
            .map { .tips }
            .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: true) ~>
            router?.present ~
        input.userAgreementTapEvent
            .combineLatest(model.userAgreementResource, model.webUserAgreementTitle)
            .map { .web($1, $2) }
            .merge(with: input.privacyPolicyTapEvent
                .combineLatest(model.privacyPolicyResource, model.webPrivacyPolicyTitle)
                .map { .web($1, $2) }
            )
            .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: true) ~>
            router.push ~ subscriptions
        
        return Output(
            navBarTitle: model.navBarTitle.eraseToAnyPublisher(),
            title: model.title.eraseToAnyPublisher(),
            description: model.description.eraseToAnyPublisher(),
            tipsTitle: model.tipsTitle.eraseToAnyPublisher(),
            userAgreementTitle: model.userAgreementTitle.eraseToAnyPublisher(),
            privacyPolicyTitle: model.privacyPolicyTitle.eraseToAnyPublisher(),
            appVersion: model.appVersion
                .map { "Версия \($0.version)" }
                .eraseToAnyPublisher()
        )
    }
}

extension CombineAboutPresenter {
    struct Input {
        let tipsTapEvent: AnyPublisher<Void, Never>
        let userAgreementTapEvent: AnyPublisher<Void, Never>
        let privacyPolicyTapEvent: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let navBarTitle: AnyPublisher<String, Never>
        let title: AnyPublisher<String, Never>
        let description: AnyPublisher<String, Never>
        let tipsTitle: AnyPublisher<String, Never>
        let userAgreementTitle: AnyPublisher<String, Never>
        let privacyPolicyTitle: AnyPublisher<String, Never>
        let appVersion: AnyPublisher<String, Never>
    }
}
