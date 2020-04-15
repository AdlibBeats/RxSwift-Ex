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

final class AboutViewModel: Transformer {
    private let model = AboutModel()
    
    func transform(input: Input) -> Output {
        Output(
            present: input.tipsTapEvent
                .map({ .tips })
                .asDriver(onErrorJustReturn: .none),
            push: Observable
                .merge(
                    input.userAgreementTapEvent.map { [model] in
                        .web(model.userAgreementResource, model.userAgreementTitle )
                    },
                    input.privacyPolicyTapEvent.map { [model] in
                        .web(model.privacyPolicyResource, model.privacyPolicyTitle )
                    }
                )
                .asDriver(onErrorJustReturn: .none)
        )
    }
}

extension AboutViewModel {
    struct Input {
        let tipsTapEvent: ControlEvent<Void>
        let userAgreementTapEvent: ControlEvent<Void>
        let privacyPolicyTapEvent: ControlEvent<Void>
    }

    struct Output {
        let present: Driver<AboutViewController.Router>
        let push: Driver<AboutViewController.Router>
    }
}
