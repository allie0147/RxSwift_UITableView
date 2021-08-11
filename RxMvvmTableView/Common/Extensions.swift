//
//  Extensions.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/08/11.
//

import Foundation

extension String {
    /// Localized String
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: self)
    }

    /// Localized String with Arguments
    func localized(with argument: CVarArg = []) -> String {
        return String(format: localized, argument)
    }
}
