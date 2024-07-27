//
//  UIView+Extension.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 29/06/24.
//

import UIKit

extension UIView {
    @IBInspectable  var cornerRadious: CGFloat{
        get { return self.cornerRadious }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
