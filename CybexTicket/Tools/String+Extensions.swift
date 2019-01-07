//
//  String+Extensions.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/7.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation

extension String {
    func snakeCased() -> String {
        let pattern = "([a-z0-9])([A-Z])"

        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased() ?? self
    }
}
