//
//  UIView+Extensions.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/15.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import UIKit
import TangramKit

extension UIView {
    func shadowCornerContainer() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
    }

    static func makeBorder(_ to: UIView? = nil) -> UIView {
        let border = UIView()
        border.tg_width ~= .fill
        border.tg_height ~= 1
        border.backgroundColor = .paleGrey

        to?.addSubview(border)
        return border
    }
}
