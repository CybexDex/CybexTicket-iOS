//
//  UINavigationController+Extensions.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/15.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setNavigationBarWith(_ color: UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
