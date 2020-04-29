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
    var present: CombineAboutRouter.State! { get set }
    var push: CombineAboutRouter.State! { get set }
}

final class CombineAboutRouter: CombineAboutRouterProtocol {
    var present: State! {
        willSet {
            Container.shared.resolve(CombineAboutViewController.self).flatMap { nc in
                makeViewController(with: newValue).flatMap { vc in
                    nc.present(vc, animated: true)
                }
            }
        }
    }
    
    var push: State! {
        willSet {
            Container.shared.resolve(UINavigationController.self, name: "CombineAboutNavigationView").flatMap { nc in
                makeViewController(with: newValue).flatMap { vc in
                    nc.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    enum State {
        case tips
        case web(WKWebView.Resource, String?)
    }
}

private func makeViewController(with state: CombineAboutRouter.State!) -> UIViewController? {
    state.flatMap {
        switch $0 {
        case .tips:
            return nil /* TODO: create TipsViewController */
        case .web(let resource, let title):
            return WKWebViewController(with: resource, title: title)
        }
    }
}
