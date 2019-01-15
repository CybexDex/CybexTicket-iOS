//
//  UILabel+Extensions.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/15.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    static func makeTitleLabel(_ text: String, to: UIView? = nil) -> UILabel {
        let label = UILabel()

        label.text = text
        label.textColor = .steel
        label.font = UIFont.makeRegularWith(14)

        to?.addSubview(label)
        return label
    }

    static func makeDescLabel(_ text: String, to: UIView? = nil) -> UILabel {
        let label = UILabel()

        label.text = text
        label.textColor = .darkTwo
        label.font = UIFont.makeRegularWith(14)

        to?.addSubview(label)
        return label
    }
}
