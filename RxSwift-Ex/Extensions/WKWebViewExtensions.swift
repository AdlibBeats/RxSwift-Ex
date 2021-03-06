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
    enum WKWebViewError: Error {
        case invalidRequest
    }
    
    enum Resource: Equatable {
        static func == (lhs: WKWebView.Resource, rhs: WKWebView.Resource) -> Bool {
            if
                case let WKWebView.Resource.local(lResource, lFileType) = lhs,
                case let WKWebView.Resource.local(rResource, rFileType) = rhs,
                lResource == rResource,
                lFileType == rFileType {
                return true
            } else if
                case let WKWebView.Resource.network(lResource, lAnchor, lHeaders) = lhs,
                case let WKWebView.Resource.network(rResource, rAnchor, rHeaders) = rhs,
                lResource == rResource,
                lAnchor == rAnchor,
                lHeaders.dictionary == rHeaders.dictionary {
                return true
            } else { return false }
        }
        
        case local(String, FileType = .html)
        case network(String, Anchor = "", HTTPHeaders = [:])
    }
    
    enum FileType: String {
        case html
    }
    
    typealias Anchor = String
    typealias Request = URLRequest
    
    static func makeRequest(_ resource: Resource) throws -> Request {
        switch resource {
        case .local(let resource, let fileType):
            guard let path = Bundle.main.path(
                forResource: resource,
                ofType: fileType.rawValue) else { throw WKWebViewError.invalidRequest }
            return URLRequest(url: URL(fileURLWithPath: path))
        case .network(let resource, let anchor, let headers):
            guard let url = URL(string: "\(resource)#\(anchor)") else { throw WKWebViewError.invalidRequest }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers.dictionary
            return request
        }
    }
}
