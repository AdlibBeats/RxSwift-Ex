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
                    .web(model.userAgreementResource.value, model.webUserAgreementTitle.value )
                },
                input.privacyPolicyTapEvent.map { [model] in
                    .web(model.privacyPolicyResource.value, model.webPrivacyPolicyTitle.value )
                }
            )
            .asDriver(onErrorJustReturn: .none)
            .drive(router.push)
            .disposed(by: disposedBag)
        
        interactor.appVersionRelay
            .asDriver()
            .drive(model.appVersion)
            .disposed(by: disposedBag)
        
        return Output(
            navBarTitle: model.navBarTitle.asDriver(),
            title: model.title.asDriver(),
            description: model.description.asDriver(),
            tipsTitle: model.tipsTitle.asDriver(),
            userAgreementTitle: model.userAgreementTitle.asDriver(),
            privacyPolicyTitle: model.privacyPolicyTitle.asDriver(),
            appVersion: model.appVersion
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
