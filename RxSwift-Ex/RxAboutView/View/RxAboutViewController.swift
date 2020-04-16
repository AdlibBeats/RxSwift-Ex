//
//  RxAboutViewController.swift
//  RxSwift-Ex
//
//  Created by Andrew on 16/04/2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit
import RxBinding
import RxSwift
import RxCocoa
import Align

final class RxAboutViewController: UIViewController {
    final class MenuButton: UIView {
        private let separatorView = UIView().then {
            $0.backgroundColor = .white
            $0.alpha = 0.15
        }
        
        private let rightArrowImageView = UIImageView().then {
            $0.image = UIImage(named: "About_WhiteRightArrow")
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        private let button = UIButton().then {
            $0.titleLabel?.font = .systemFont(ofSize: 15)
            $0.setTitleColor(.white, for: .normal)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        }
        
        init() {
            super.init(frame: .zero)
            
            addSubview(separatorView, rightArrowImageView, button) {
                $0.edges(.left, .top, .right).pinToSuperview()
                $0.height.set(1)
                
                $1.edges(.right).pinToSuperview(insets: .init(top: 0, left: 0, bottom: 0, right: 20))
                $1.centerY.alignWithSuperview()
                $1.size.set(.init(width: 8, height: 13))
                $1.edges(.top, .bottom).pinToSuperview(insets: .zero, relation: .greaterThanOrEqual)
                
                $2.edges(.bottom, .left, .top).pinToSuperview()
                $2.right.align(with: $1.left - 20)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var tap: ControlEvent<Void> {
            button.rx.tap
        }
        
        func title(for controlState: UIControl.State = []) -> Binder<String?> {
            button.rx.title(for: controlState)
        }
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.bouncesZoom = false
        $0.alwaysBounceVertical = true
        $0.clipsToBounds = true
    }
    
    private let rootView = UIView()
    
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "About_Background")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let applicationIconImageView = UIImageView().then {
        $0.image = UIImage(named: "About_AppIcon")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .white
    }
    
    private let appVersionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let menuButtonsStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.15
    }
    
    private let tipsButton = MenuButton()
    private let userAgreementButton = MenuButton()
    private let privacyPolicyButton = MenuButton()
    
    typealias Input = RxAboutPresenter.Input
    typealias Output = RxAboutPresenter.Output
    
    var presenter: RxAboutPresenterProtocol!
    
    private let configurator: RxAboutConfiguratorProtocol = RxAboutConfigurator()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem().then {
            $0.tintColor = .init(red: 0.937, green: 0.565, blue: 0.729, alpha: 1)
        }
        
        func setConstraints() {
            func setRootView() {
                view.addSubview(backgroundImageView, scrollView) {
                    $0.edges.pinToSuperview()
                    $1.edges(.left, .right).pinToSuperview()
                    $1.edges(.top, .bottom).pinToSafeArea(of: self)
                }
                
                scrollView.addSubview(rootView) {
                    $0.edges.pinToSuperview()
                }
                
                Constraints(for: scrollView, rootView) {
                    $1.width.match($0.width)
                    $1.height.match($0.height).priority = .init(250)
                }
            }
            
            func setLabels() {
                rootView.addSubview(applicationIconImageView, titleLabel, appVersionLabel, descriptionLabel) {
                    $0.edges(.top).pinToSuperview(insets: .init(top: 24, left: 0, bottom: 0, right: 0))
                    $0.edges(.left, .right).pinToSuperview(insets: .zero, relation: .greaterThanOrEqual)
                    $0.centerX.alignWithSuperview()
                    $0.size.set(.init(width: 115, height: 107))
                    
                    $1.top.align(with: $0.bottom + 35)
                    $1.edges(.left, .right).pinToSuperview(insets: .zero, relation: .greaterThanOrEqual)
                    $1.centerX.alignWithSuperview()
                    
                    $2.top.align(with: $1.bottom + 10)
                    $2.edges(.left, .right).pinToSuperview(insets: .zero, relation: .greaterThanOrEqual)
                    $2.centerX.alignWithSuperview()
                    
                    $3.top.align(with: $2.bottom + 30)
                    $3.edges(.left, .right).pinToSuperview(insets: .zero, relation: .greaterThanOrEqual)
                    $3.centerX.alignWithSuperview()
                    $3.width.set(295).priority = .init(999)
                }
            }
            
            func setStackViews() {
                [tipsButton, privacyPolicyButton, userAgreementButton].forEach(menuButtonsStackView.addArrangedSubview)
                
                rootView.addSubview(menuButtonsStackView, separatorView) {
                    $0.edges(.bottom).pinToSuperview()
                    $0.edges(.left, .right).pinToSuperview(insets: .zero, relation: .greaterThanOrEqual)
                    $0.centerX.alignWithSuperview()
                    $0.width.set(375).priority = .init(999)
                    
                    $1.top.align(with: $0.bottom)
                    $1.edges(.left, .right).pinToSuperview(insets: .zero, relation: .greaterThanOrEqual)
                    $1.centerX.alignWithSuperview()
                    $1.width.set(375).priority = .init(999)
                    $1.height.set(1)
                }
                
                Constraints(for: descriptionLabel, menuButtonsStackView) {
                    $1.top.align(with: $0.bottom + 30, relation: .greaterThanOrEqual)
                }
            }
            
            func setMenuButtonsSize() {
                Constraints(for: tipsButton, privacyPolicyButton, userAgreementButton) {
                    $0.height.set(53)
                    $1.height.match($0.height)
                    $2.height.match($0.height)
                }
            }
            
            setRootView()
            setLabels()
            setStackViews()
            setMenuButtonsSize()
        }
        
        func bind() {
            let output = presenter.transform(
                input: RxAboutPresenter.Input(
                    tipsTapEvent: tipsButton.tap,
                    userAgreementTapEvent: userAgreementButton.tap,
                    privacyPolicyTapEvent: privacyPolicyButton.tap
                )
            )
            
            disposeBag ~ [
                output.navBarTitle ~> rx.title,
                output.title ~> titleLabel.rx.text,
                output.description ~> descriptionLabel.rx.text,
                output.tipsTitle ~> tipsButton.title(for: .normal),
                output.userAgreementTitle ~> userAgreementButton.title(for: .normal),
                output.privacyPolicyTitle ~> privacyPolicyButton.title(for: .normal),
                output.appVersion ~> appVersionLabel.rx.text
            ]
        }
        
        setConstraints()
        bind()
    }
}
