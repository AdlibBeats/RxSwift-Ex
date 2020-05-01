//
//  CombineAboutRouter.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Combine
import WebKit
import Swinject

protocol CombineAboutRouterProtocol: class {
    var present: ((CombineAboutRouter.State) -> Void) { get }
    var push: ((CombineAboutRouter.State) -> Void) { get }
}

final class CombineAboutRouter: CombineAboutRouterProtocol {
    enum State {
        case tips
        case web(WKWebView.Resource, String?)
    }
    
    let present: ((CombineAboutRouter.State) -> Void) = { state in
        Container.shared.resolve(CombineAboutViewController.self).flatMap { nc in
            makeViewController(with: state).flatMap { vc in
                nc.present(vc, animated: true)
            }
        }
    }
    
    let push: ((CombineAboutRouter.State) -> Void) = { state in
        Container.shared.resolve(UINavigationController.self, name: "CombineAboutNavigationView").flatMap { nc in
            makeViewController(with: state).flatMap { vc in
                nc.pushViewController(vc, animated: true)
            }
        }
    }
}

private func makeViewController(with state: CombineAboutRouter.State) -> UIViewController? {
    switch state {
    case .tips:
        return nil /* TODO: create TipsViewController */
    case .web(let resource, let title):
        return WKWebViewController(with: resource, title: title)
    }
}
