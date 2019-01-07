//
//  Asset.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/7.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import HandyJSON

class AssetInfo: HandyJSON {
    var precision: Int = 0
    var id: String = ""
    var symbol: String = ""
    var dynamicAssetDataId: String = ""

    required init() {}

    func mapping(mapper: HelpingMapper) {
        mapper <<< precision            <-- "precision"
        mapper <<< id                   <--  "id"
        mapper <<< symbol               <--  "symbol"
        mapper <<< dynamicAssetDataId <--  "dynamic_asset_data_id"
    }
}

class Asset: HandyJSON {
    var amount: String = ""
    var assetID: String = ""

    init(amount: String, assetID: String) {
        self.amount = amount
        self.assetID = assetID
    }

    required init() {}

    func mapping(mapper: HelpingMapper) {
        mapper <<< amount               <-- ("amount", ToStringTransform())
        mapper <<< assetID              <-- "asset_id"
    }
}
