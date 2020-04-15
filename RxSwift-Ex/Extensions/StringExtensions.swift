//
//  StringExtensions.swift
//  RxSwift-Ex
//
//  Created by Andrew on 03/10/2019.
//  Copyright © 2019 ru.proarttherapy. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
}
