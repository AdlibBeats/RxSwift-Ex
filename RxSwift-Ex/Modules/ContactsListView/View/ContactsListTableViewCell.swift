//
//  ContactsListTableViewCell.swift
//  RxSwift-Ex
//
//  Created by Andrew on 18.04.2020.
//  Copyright © 2020 ru.proarttherapy. All rights reserved.
//

import UIKit

protocol ContactsListTableViewCellDelegate: class {
    func videoCall(to contact: Contact)
    func audioCall(to contact: Contact)
}

final class ContactsListTableViewCell: UITableViewCell {
    weak var delegate: ContactsListTableViewCellDelegate!
    
    var contact: Contact! {
        willSet {
            shortNameLabel.text = "\(newValue?.firstName?[0] ?? "") \(newValue?.lastName?[0] ?? "")"
            displayNameLabel.text = newValue?.displayName ?? ""
            positionLabel.text = newValue?.position ?? ""
        }
    }
    
    @IBOutlet private weak var shortNameLabel: UILabel!
    @IBOutlet private weak var displayNameLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    
    
    @IBAction private func videoCallDidTap(_ sender: UIButton) {
        delegate.flatMap { [weak self] delegate in
            self?.contact.flatMap {
                delegate.videoCall(to: $0)
            }
        }
    }
    
    @IBAction private func audioCallDidTap(_ sender: UIButton) {
        delegate.flatMap { [weak self] delegate in
            self?.contact.flatMap {
                delegate.audioCall(to: $0)
            }
        }
    }
}

private extension String {
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
