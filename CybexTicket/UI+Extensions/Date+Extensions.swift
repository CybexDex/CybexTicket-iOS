//
//  Date+Extensions.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/18.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation

extension Formatter {
    static let UTC: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // 默认为系统当前的时区
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
}

extension Date {
    var UTC: String {
        return Formatter.UTC.string(from: self)
    }
}
