//
//  Constants.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/28.
//

import Foundation

struct Constants {
}

extension UIStoryboard {

    enum name: String {
        case main = "Main"
    }

    class func getSB(name: UIStoryboard.name) -> Self {
        return UIStoryboard(name: name.rawValue, bundle: nil) as! Self
    }
}
