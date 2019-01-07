//
//  ModelUtils.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/7.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import HandyJSON

class ToStringTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String

    public init() {}

    open func transformFromJSON(_ value: Any?) -> String? {
        if let val = value as? Double {
            return val.description
        } else if let val = value as? String {
            return val
        } else if let val = value as? Int {
            return val.description
        }

        return nil
    }

    open func transformToJSON(_ value: String?) -> String? {
        if let val = value {
            return val
        }
        return nil
    }
}
