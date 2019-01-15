//
//  UITextField+Extensions.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/15.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import UIKit
import TangramKit

extension UITextField {
    static func makeTextField(_ hint: String, to: UIView? = nil) -> UITextField {
        let textfield = UITextField()

        textfield.font = UIFont.makeMediumWith(16)
        textfield.textColor = .darkTwo
        textfield.placeholder = hint
        textfield.tg_size(width: .fill, height: .wrap)

        to?.addSubview(textfield) 
        return textfield
    }
}
