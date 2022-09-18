//
//  View+extension.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2022/09/18.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView ...) {
        for view in views {
            addSubview(view)
        }
    }
}
