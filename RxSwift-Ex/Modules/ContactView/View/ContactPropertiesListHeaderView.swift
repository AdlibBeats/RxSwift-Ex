//
//  ContactPropertiesListHeaderView.swift
//  RxSwift-Ex
//
//  Created by Andrew on 29.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit


final class ContactPropertiesListHeaderView: UIView {
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private weak var activeTimeLabel: UILabel!
    @IBOutlet private weak var displayNameLabel: UILabel!
    @IBOutlet private weak var shortNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ContactPropertiesListHeaderView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    var activeTime: String? {
        get { activeTimeLabel?.text }
        set { activeTimeLabel?.text = newValue }
    }
    
    var displayName: String? {
        get { displayNameLabel?.text }
        set { displayNameLabel?.text = newValue }
    }
    
    var shortName: String? {
        get { shortNameLabel?.text }
        set { shortNameLabel?.text = newValue }
    }
}
