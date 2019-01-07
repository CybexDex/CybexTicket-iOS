//
//  Vesting.swift
//  cybexMobile
//
//  Created by koofrank on 2018/5/19.
//  Copyright © 2018年 Cybex. All rights reserved.
//

import Foundation
import HandyJSON

class LockUpAssetsMData: HandyJSON, NSCopying {
    var id: String = ""
    var owner: String = ""
    var balance: Asset = Asset()
    var vestingPolicy: VestingPolicy = VestingPolicy()
    var lastClaimDate: String = ""

    required init() {
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = LockUpAssetsMData.deserialize(from: self.toJSON())
        return copy ?? LockUpAssetsMData()
    }

    func mapping(mapper: HelpingMapper) {
        mapper <<< id                  <-- ("id", ToStringTransform())
        mapper <<< owner               <-- ("owner", ToStringTransform())
        mapper <<< balance             <-- "balance"
        mapper <<< vestingPolicy      <-- "vesting_policy"
        mapper <<< lastClaimDate     <-- ("last_claim_date", ToStringTransform())
    }
}

class VestingPolicy: HandyJSON {
    var beginTimestamp: String = ""
    var vestingCliffSeconds: String = ""
    var vestingDurationSeconds: String = ""
    var beginBalance: String = ""

    required init() {
    }

    func mapping(mapper: HelpingMapper) {
        mapper <<< beginTimestamp                <-- ("begin_timestamp", ToStringTransform())
        mapper <<< vestingCliffSeconds          <-- ("vesting_cliff_seconds", ToStringTransform())
        mapper <<< vestingDurationSeconds       <-- ("vesting_duration_seconds", ToStringTransform())
        mapper <<< beginBalance                  <-- ("begin_balance", ToStringTransform())
    }
}
