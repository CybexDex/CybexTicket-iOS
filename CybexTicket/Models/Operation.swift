//
//  Operation.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/12.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import HandyJSON

class Transfer: HandyJSON, NSCopying {
    var from: String = ""
    var to: String = ""
    var fee: Asset = Asset()
    var amount: Asset = Asset()

    required init() {
    }

    func mapping(mapper: HelpingMapper) {
        mapper <<< from                   <-- ("from", ToStringTransform())
        mapper <<< to          <-- ("to", ToStringTransform())
        mapper <<< fee         <-- "fee"
        mapper <<< amount            <-- "amount"
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Transfer.deserialize(from: self.toJSON())
        return copy ?? Transfer()
    }

    static func empty() -> Transfer {
        return Transfer()
    }
}
