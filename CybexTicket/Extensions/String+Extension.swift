//
//  String+Extension.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/14.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation

extension String {
    static var numberFormatters: [NumberFormatter] = []
    static var doubleFormat: NumberFormatter = NumberFormatter()

    var filterJade: String {
        // 正式
        return self.replacingOccurrences(of: "JADE.", with: "").replacingOccurrences(of: "JADE_", with: "").replacingOccurrences(of: "JADE", with: "")
    }

    var getSuffixID: Int32 {
        if self == "" {
            return 0
        }

        if let id = self.components(separatedBy: ".").last {
            return Int32(id)!
        }

        return 0
    }

    var int32: Int32 {
        if self == "" {
            return 0
        }

        return Int32(self)!
    }

    var int64: Int64 {
        if self == "" {
            return 0
        }

        return Int64(self)!
    }

    public func decimal() -> Decimal {
        if self == "" {
            return Decimal(0)
        }
        var selfString = self
        if selfString.contains(",") {
            selfString = selfString.replacingOccurrences( of: "[^0-9.]", with: "", options: .regularExpression)
        }
        return Decimal(string: selfString) ?? Decimal(0)
    }

}
