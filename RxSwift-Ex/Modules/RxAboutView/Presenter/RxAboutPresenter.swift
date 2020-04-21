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
        interactor.appVersion ~> model.appVersion ~
        input.tipsTapEvent.map { .tips } ~> router.presentBinder ~
        Observable.merge(
            input.userAgreementTapEvent.withLatestFrom(Observable.combineLatest(
                    model.userAgreementResource,
                    model.webUserAgreementTitle
                )
            ).map { .web($0, $1) },
            input.privacyPolicyTapEvent.withLatestFrom(Observable.combineLatest(
                    model.privacyPolicyResource,
                    model.webPrivacyPolicyTitle
                )
            ).map { .web($0, $1) }
        ) ~> router.pushBinder ~ disposedBag
        
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
        let tipsTapEvent: Observable<Void>
        let userAgreementTapEvent: Observable<Void>
        let privacyPolicyTapEvent: Observable<Void>
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
