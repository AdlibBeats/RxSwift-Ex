//
//  AboutViewModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.10.2019.
//  Copyright © 2019 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa
import WebKit
import RealmSwift
import RxRealm

protocol AboutPresenterProtocol: class {
    func transform(input: AboutPresenter.Input) -> AboutPresenter.Output
}

final class AboutPresenter: AboutPresenterProtocol {
    private var model = AboutModel()
    private let disposedBag = DisposeBag()
    
    private weak var view: AboutViewProtocol!
    
    required init(view: AboutViewProtocol) {
        self.view = view
    }
    
    var router: AboutRouterProtocol!
    var interactor: AboutInteractorProtocol!
    
    func transform(input: Input) -> Output {
        input.tipsTapEvent
            .map({ .tips })
            .asDriver(onErrorJustReturn: .none)
            .drive(router.present)
            .disposed(by: disposedBag)
        
        Observable
            .merge(
                input.userAgreementTapEvent.map { [model] in
                    .web(model.userAgreementResource, model.webUserAgreementTitle )
                },
                input.privacyPolicyTapEvent.map { [model] in
                    .web(model.privacyPolicyResource, model.webPrivacyPolicyTitle )
                }
            )
            .asDriver(onErrorJustReturn: .none)
            .drive(router.push)
            .disposed(by: disposedBag)
        
        return Output(
            navBarTitle: Observable
                .just(model.navBarTitle)
                .asDriver(onErrorJustReturn: ""),
            title: Observable
                .just(model.title)
                .asDriver(onErrorJustReturn: ""),
            description: Observable
                .just(model.description)
                .asDriver(onErrorJustReturn: ""),
            tipsTitle: Observable
                .just(model.tipsTitle)
                .asDriver(onErrorJustReturn: ""),
            userAgreementTitle: Observable
                .just(model.userAgreementTitle)
                .asDriver(onErrorJustReturn: ""),
            privacyPolicyTitle: Observable
                .just(model.privacyPolicyTitle)
                .asDriver(onErrorJustReturn: ""),
            appVersion: interactor.appVersionRelay
                .compactMap({ $0?.version })
                .asDriver(onErrorJustReturn: "")
        )
    }
}

extension AboutPresenter {
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
