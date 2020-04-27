//
//  ContactsListTableViewCell.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

protocol ContactsListTableViewCellDelegate: class {
    func videoCall()
    func audioCall()
}

final class ContactsListTableViewCell: UITableViewCell {
    weak var delegate: ContactsListTableViewCellDelegate!
    
    @IBOutlet weak var firstCharOfFirstNameLabel: UILabel!
    @IBOutlet weak var firstCharOfLastNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBAction func videoCallDidTap(_ sender: UIButton) {
        delegate?.videoCall()
    }
    
    @IBAction func audioCallDidTap(_ sender: UIButton) {
        delegate?.audioCall()
    }
}
