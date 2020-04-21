//
//  RxAboutRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxSwift
import RxCocoa
import WebKit

protocol RxRouterProtocol: class {
    var viewController: UIViewController! { get set }
    var navigationController: UINavigationController! { get set }
}

class RxBaseRouter: RxRouterProtocol {
    weak var viewController: UIViewController!
    weak var navigationController: UINavigationController!
}

protocol RxAboutRouterProtocol: class {
    var presentBinder: Binder<RxAboutRouter.State> { get }
    var pushBinder: Binder<RxAboutRouter.State> { get }
}

final class RxAboutRouter: RxBaseRouter { }

extension RxAboutRouter: RxAboutRouterProtocol {
    enum State {
        case tips
        case web(WKWebView.Resource, String?)
    }
    
    var presentBinder: Binder<State> {
        viewController.rx.present
    }

    var pushBinder: Binder<State> {
        navigationController.rx.push
    }
}

private func makeViewController(with state: RxAboutRouter.State) -> UIViewController? {
    switch state {
    case .tips:
        return nil /* TODO: create TipsViewController */
    case .web(let resource, let title):
        return WKWebViewController(with: resource, title: title)
    }
}

private extension Reactive where Base : UIViewController {
    var present: Binder<RxAboutRouter.State> {
        Binder(base) { viewController, value in
            makeViewController(with: value).flatMap {
                viewController.present($0, animated: true)
            }
        }
    }
}

private extension Reactive where Base : UINavigationController {
    var push: Binder<RxAboutRouter.State> {
        Binder(base) { navigationController, value in
            makeViewController(with: value).flatMap {
                navigationController.pushViewController($0, animated: true)
            }
        }
    }
}

