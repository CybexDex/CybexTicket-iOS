//
//  BinHelper.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/18.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation

class BinHelper {
    class func deserializeTransaction(_ str: String) -> String {
        guard let data = Data(base64Encoded: str, options: .ignoreUnknownCharacters) else { return "" }

        let prefixData = data.subdata(in: 0..<32)
        let suffixData = data.subdata(in: 32..<data.count)
        let suffixstr = hexlify(suffixData)

        guard let unpackedData = try? unpack("<4iqd", prefixData),
            let fromAccount = unpackedData[0] as? Int,
            let toAccount = unpackedData[1] as? Int,
            let assetId = unpackedData[2] as? Int,
            let blockNum = unpackedData[3] as? Int,
            let amount = unpackedData[4] as? Int,
            let time = unpackedData[5] as? Double,
            let bid = suffixstr.slicing(from: 0, length: 10),
            let signedStr = suffixstr.slicing(from: 10, length: suffixstr.count - 10) else {
                return ""
        }

        let timestr = Date(timeIntervalSince1970: time).UTC

        let transaction = "{\"ref_block_num\":\(blockNum),\"ref_block_prefix\":\(bid),\"expiration\":\"\(timestr)\",\"operations\":[[0,{\"fee\":{\"amount\":1000,\"asset_id\":\"1.3.0\"},\"from\":\"1.2.\(fromAccount)\",\"to\":\"1.2.\(toAccount)\",\"amount\":{\"amount\":\(amount),\"asset_id\":\"1.3.\(assetId)\"},\"extensions\":[]}]],\"extensions\":[],\"signatures\":[\"\(signedStr)\"]}"

        return transaction
    }
}
