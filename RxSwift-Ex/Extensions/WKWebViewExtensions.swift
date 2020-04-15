//
//  WKWebViewExtensions.swift
//  RxSwift-Ex
//
//  Created by Andrew on 03/10/2019.
//  Copyright © 2019 ru.proarttherapy. All rights reserved.
//

import WebKit
import Alamofire

extension WKWebView {
    enum Resource {
        case local(String, FileType = .html)
        case network(String, Anchor = nil, HTTPHeaders = [:])
    }
    
    enum FileType: String {
        case html
    }
    
    typealias Anchor = String?
    typealias Request = URLRequest?
    
    static func makeRequest(_ resource: Resource) -> Request {
        switch resource {
        case .local(let resource, let fileType):
            guard let path = Bundle.main.path(
                forResource: resource,
                ofType: fileType.rawValue) else { return nil }
            return URLRequest(url: URL(fileURLWithPath: path))
        case .network(let resource, let anchor, let headers):
            guard let url = URL(string: "\(resource)#\(anchor ?? "")") else { return nil }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}
