//
//  WKWebViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 27.02.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import RxBinding
import RxSwift
import RxCocoa
import Align
import WebKit
import Alamofire
import Then

final class WKWebViewController: UIViewController {
    private let resource: WKWebView.Resource
    private let webView = WKWebView().then {
        $0.backgroundColor = .white
        
        $0.scrollView.showsVerticalScrollIndicator = false
        $0.scrollView.showsHorizontalScrollIndicator = false
        $0.scrollView.bouncesZoom = false
        $0.scrollView.alwaysBounceVertical = true
        $0.scrollView.clipsToBounds = true
    }
    
    init(with resource: WKWebView.Resource, title: String? = nil) {
        self.resource = resource
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        webView.navigationDelegate = self
        
        func setConstraints() {
            view.addSubview(webView) {
                $0.edges(.left, .top, .right).pinToSuperview()
                $0.edges(.bottom).pinToSafeArea(of: self)
            }
        }
        
        func bind() {
            Observable.just(resource) ~> webView.rx.load ~ disposeBag
        }
        
        setConstraints()
        bind()
    }
}

extension WKWebViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        navigationAction.navigationType == .linkActivated ?
            decisionHandler(.cancel) :
            decisionHandler(.allow)
    }
}
