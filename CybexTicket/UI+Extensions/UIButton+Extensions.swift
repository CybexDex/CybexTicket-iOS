//
//  UIButton+Extensions.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/15.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    static func makeFormButton(_ title: String, to: UIView? = nil) -> UIButton {
        let button = UIButton()

        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.makeRegularWith(16)
        button.titleColorForNormal = .white
        button.setBackgroundImage(R.image.btnColorOrange(), for: .normal)
        button.setBackgroundImage(R.image.btnColorGrey(), for: .disabled)

        to?.addSubview(button)
        return button
    }
}
