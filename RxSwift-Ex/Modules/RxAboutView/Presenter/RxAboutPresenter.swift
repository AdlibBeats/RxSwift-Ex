//
//  RxAboutPresenter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxBinding
import RxSwift
import RxCocoa
import WebKit

protocol RxAboutPresenterProtocol: class {
    typealias Input = RxAboutPresenter.Input
    typealias Output = RxAboutPresenter.Output
    
    func transform(input: Input) -> Output
}

final class RxAboutPresenter: RxAboutPresenterProtocol {
    typealias Router = RxAboutRouterProtocol
    typealias Interactor = RxAboutInteractorProtocol
    
    private var model = RxAboutModel()
    private let disposedBag = DisposeBag()
    
    var router: Router!
    var interactor: Interactor!
    
    func transform(input: Input) -> Output {
        interactor.appVersionRelay ~> model.appVersion ~
        input.tipsTapEvent.map { .tips } ~> router.present ~
        Observable.merge(
            input.userAgreementTapEvent.map { [model] in
                .web(model.userAgreementResource.value, model.webUserAgreementTitle.value )
            },
            input.privacyPolicyTapEvent.map { [model] in
                .web(model.privacyPolicyResource.value, model.webPrivacyPolicyTitle.value )
            }
        ) ~> router.push ~ disposedBag
        
        return Output(
            navBarTitle: model.navBarTitle.asDriver(),
            title: model.title.asDriver(),
            description: model.description.asDriver(),
            tipsTitle: model.tipsTitle.asDriver(),
            userAgreementTitle: model.userAgreementTitle.asDriver(),
            privacyPolicyTitle: model.privacyPolicyTitle.asDriver(),
            appVersion: model.appVersion
                .map({ "Версия \($0.version)" })
                .asDriver(onErrorJustReturn: "")
        )
    }
}

extension RxAboutPresenter {
    struct Input {
        let tipsTapEvent: ControlEvent<Void>
        let userAgreementTapEvent: ControlEvent<Void>
        let privacyPolicyTapEvent: ControlEvent<Void>
    }

    struct Output {
        let navBarTitle: Driver<String>
        let title: Driver<String>
        let description: Driver<String>
        let tipsTitle: Driver<String>
        let userAgreementTitle: Driver<String>
        let privacyPolicyTitle: Driver<String>
        let appVersion: Driver<String>
    }
}
