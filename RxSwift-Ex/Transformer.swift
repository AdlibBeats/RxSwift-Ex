//
//  Transformer.swift
//  RxSwift-Ex
//
//  Created by Andrew on 15.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import Foundation

protocol Transformer {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
