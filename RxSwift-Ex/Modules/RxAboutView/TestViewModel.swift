//
//  TestViewModel.swift
//  RxSwift-Ex
//
//  Created by Andrew on 03.07.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBinding
import Then

protocol TestViewModelProtocol: class {
    typealias Input = TestViewModel.Input
    typealias Output = TestViewModel.Output
    
    func transform(_ input: Input) -> Output
}

final class TestViewModel: TestViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let model = Model()
    
    init() {
        
    }
    
    func transform(_ input: Input) -> Output {
        let output = Output(testEvent: Observable<String>.just("Hello world"))
        
        
        
        return output
    }
}

// Mark: Model, Input, Output
extension TestViewModel {
    struct Model {
        
    }
    
    struct Input {
        
    }
    
    struct Output {
        let testEvent: Observable<String>
        
    }
}

// MARK: Then
extension TestViewModel.Model: Then { }

final class TestViewController: UIViewController {
    typealias ViewModel = TestViewModelProtocol
    
    private let disposeBag = DisposeBag()
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        
        func setConstraints() {
            
        }
        
        func bind() {
            let output = viewModel.transform(.init())
            
            
            
            output.testEvent ~> rx.title ~ disposeBag
        }
        
        setConstraints()
        bind()
    }
}

