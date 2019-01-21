//
//  ViewController.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/7.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import UIKit
import TangramKit
import SwiftyJSON
import BeareadToast_swift

class ViewController: UIViewController {
    
    weak var scanButton: UIButton!
    weak var accountTextField: UITextField!
    weak var ticketTextField: UITextField!
    weak var scanResultLayout: TGLinearLayout!
    weak var userLayout: TGLinearLayout!
    weak var checkedAccountNameLabel: UILabel!
    weak var checkedTicketAmountLabel: UILabel!

    weak var userResultLayout: TGRelativeLayout!
    weak var userResultLabel: UILabel!
    weak var userResultImageView: UIImageView!

    var transaction: String?

    var chooseAsset: AssetInfo?
    var toAccount: Account?

    var useAccountName: String?
    var useAmount: String?

    var successHint: String {
        guard let useAccountName = useAccountName, let useAmount = useAmount else { return "" }

        return  "验证通过！\n \n" + "乘客账户   \(useAccountName)\n" + "船票张数   \(useAmount)"
    }

    override func loadView() {
        super.loadView()

        initView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isTranslucent = false
    }

}

// MARK: - Route

extension ViewController {
    func pushToScanViewController() {
        let scanVC = ScanViewController()
        scanVC.scanResult.delegate(on: self) { (self, result) in
            self.handleTicket(result)
        }

        self.navigationController?.pushViewController(scanVC)
    }
}

// MARK: - Event

extension ViewController {
    @objc func userButtonClicked() {
        sendToChain()
    }

    @objc func scanButtonClicked() {
        transaction = nil

        pushToScanViewController()
    }

    @objc func updateScanButtonState() {
        validateReferenceTicketInfo()
    }
}

// MARK: - Logic

extension ViewController {
    func handleTicket(_ result: String) {
        guard self.transaction != result else { return }

        self.transaction = result

        resetScanResultPanel()

        let (_, operation) = validateTicketForm(result)
        guard let transferObject = operation else {
            showCheckedResultPanel(true)
            return
        }

        showScanSuccessResultPanel()

        getAccount(transferObject.from) {[weak self] (account) in
            guard let self = self, let account = account else { return }

            self.useAccountName = account.name
            self.useAmount = self.getRealAmount(self.chooseAsset, amount: transferObject.amount.amount).string
            self.fillScanResultPanel(account.name, amount: self.getRealAmount(self.chooseAsset, amount: transferObject.amount.amount).string)
        }
    }

    func validateTicketForm(_ result: String) -> (valid: Bool, operation: Transfer?) {
        guard let toAccount = toAccount, let chooseAsset = chooseAsset else { return (false, nil) }

        let json = JSON(parseJSON: result)

        guard let operation = json["operations"][0][1].dictionaryObject,
            let transferObject = Transfer.deserialize(from: operation) else { return (false, nil) }

        guard transferObject.amount.assetID == chooseAsset.id,
            transferObject.to == toAccount.id else {
                return (false, nil)
        }

        return (true, transferObject)
    }

    func validateReferenceTicketInfo() {
        let account = self.accountTextField.text ?? ""
        let ticket = self.ticketTextField.text ?? ""
        guard !account.isEmpty, !ticket.isEmpty else {
            self.scanButton.isEnabled = false
            return
        }

        getAccount(account) {[weak self] (account) in
            guard let self = self else { return }

            guard let account = account else {
                self.scanButton.isEnabled = false
                return
            }
            self.toAccount = account
            self.scanButton.isEnabled = self.toAccount != nil && self.chooseAsset != nil
        }

        getAsset(ticket, callback: {[weak self] (asset) in
            guard let self = self else { return }

            guard let asset = asset else {
                self.scanButton.isEnabled = false
                return
            }
            self.chooseAsset = asset
            self.scanButton.isEnabled = self.toAccount != nil && self.chooseAsset != nil
        })
    }

    func getRealAmount(_ asset: AssetInfo?, amount: String) -> Decimal {
        guard let asset = asset else { return 0 }
        let precisionNumber = pow(10, asset.precision)

        return amount.decimal() / precisionNumber
    }
}

// MARK: - Network
extension ViewController {
    func sendToChain() {
        guard let transaction = transaction else { return }

        _ = BeareadToast.showLoading(inView: self.view)

        CybexWebSocketService.shared.connect()

        CybexWebSocketService.shared.canSendMessage.delegate(on: self) { (self, _) in
            let request = BroadcastTransactionRequest(response: { (data) in
                _ = BeareadToast.hideIn(self.view)

                if String(describing: data) == "<null>" {
                    self.showCheckedResultPanel(false)
                }
                else {
                    self.showCheckedResultPanel(true)
                }

                CybexWebSocketService.shared.disconnect()
            }, jsonstr: transaction)

            CybexWebSocketService.shared.send(request: request)
        }
    }

    func getAccount(_ from: String, callback: @escaping (Account?) -> Void) {
        CybexDatabaseApiService.request(target: .getAccount(name: from), success: { (json) in
            guard json.arrayValue.count != 0, let account = json[0][1]["account"].dictionaryObject, let accountObject = Account.deserialize(from: account) else {
                callback(nil)
                return
            }

            callback(accountObject)
        }, error: { (error) in

        }) { (error) in

        }
    }

    func getAsset(_ ticket: String, callback: @escaping (AssetInfo?) -> Void) {
        CybexDatabaseApiService.request(target: .lookupSymbol(name: ticket), success: { (assetJson) in
            guard assetJson.arrayValue.count != 0, let data = assetJson[0].dictionaryObject, let asset = AssetInfo.deserialize(from: data) else {
                callback(nil)
                return
            }

            callback(asset)
        }, error: { (error2) in

        }, failure: { (error2) in

        })
    }
}

// MARK: - UI Logic
extension ViewController {
    func showScanSuccessResultPanel() {
        scanResultLayout.tg_visibility = .visible
        userLayout.tg_visibility = .visible
        userResultLayout.tg_visibility = .gone
    }

    func showCheckedResultPanel(_ isInvalid: Bool) {
        fillUserResult(isInvalid)

        scanResultLayout.tg_visibility = .visible
        userLayout.tg_visibility = .gone
        userResultLayout.tg_visibility = .visible
    }

    func resetScanResultPanel() {
        fillScanResultPanel("", amount: "")
    }

    func fillScanResultPanel(_ name: String, amount: String) {
        checkedAccountNameLabel.text = "乘客账户   \(name)"
        checkedTicketAmountLabel.text = "船票张数   \(amount)"
    }

    func fillUserResult(_ isInvalid: Bool) {
        userResultLabel.text = isInvalid ? "无效票，请重新扫码！" : successHint
        userResultImageView.image = isInvalid ? R.image.icInvalidTicket() : R.image.icUsedTicket()
    }
}

