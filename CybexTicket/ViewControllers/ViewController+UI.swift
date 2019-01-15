//
//  ViewController+UI.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/15.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import Foundation
import TangramKit

extension ViewController {
    func initView() {
       
        self.title = "Cybex验票终端"
        setNavigationBarWith(.yellow)

        self.edgesForExtendedLayout = UIRectEdge(rawValue:0)

        let rootLayout = TGLinearLayout(.vert)
        rootLayout.backgroundColor = .yellow
        rootLayout.tg_width ~= .fill
        rootLayout.tg_height ~= .fill
        self.view = rootLayout

        initScanLayout(rootLayout)
        initScanResultLayout(rootLayout);
    }

    func initScanLayout(_ rootLayout: TGLinearLayout) {
        let scanLayout = TGLinearLayout(.vert)
        scanLayout.shadowCornerContainer()

        scanLayout.tg_width ~= .fill
        scanLayout.tg_height ~= .wrap
        scanLayout.tg_top ~= 12
        scanLayout.tg_horzMargin(Dimen.mainHorzMargin.rawValue)
        scanLayout.tg_padding = UIEdgeInsets(top: 26, left: 20, bottom: 30, right: 15)
        rootLayout.addSubview(scanLayout)

        let accountLabel = UILabel.makeTitleLabel("验证账户", to: scanLayout)
        accountLabel.tg_size(width: .wrap, height: .wrap)

        let accountTextField = UITextField.makeTextField("请输入验证账户", to: scanLayout)
        accountTextField.addTarget(self, action: #selector(updateScanButtonState), for: .editingChanged)
        self.accountTextField = accountTextField
        accountTextField.tg_top ~= 7

        let divider_account = UIView.makeBorder(scanLayout)
        divider_account.tg_top ~= 7

        let ticketLabel = UILabel.makeTitleLabel("票名称", to: scanLayout)
        ticketLabel.tg_top ~= 14
        ticketLabel.tg_size(width: .wrap, height: .wrap)

        let ticketTextField = UITextField.makeTextField("请输入票名称", to: scanLayout)
        ticketTextField.addTarget(self, action: #selector(updateScanButtonState), for: .editingChanged)
        self.ticketTextField = ticketTextField
        ticketTextField.tg_top ~= 7

        let divider_ticket = UIView.makeBorder(scanLayout)
        divider_ticket.tg_top ~= 7

        let scanButton = UIButton.makeFormButton("扫码", to: scanLayout)
        scanButton.isEnabled = false
        scanButton.addTarget(self, action: #selector(scanButtonClicked), for: .touchUpInside)
        self.scanButton = scanButton
        scanButton.tg_height ~= 40
        scanButton.tg_top ~= 20
        scanButton.tg_width ~= .fill

    }

    func initScanResultLayout(_ rootLayout: TGLinearLayout) {
        let scanResultLayout = TGLinearLayout(.vert)
        scanResultLayout.shadowCornerContainer()

        scanResultLayout.tg_width ~= .fill
        scanResultLayout.tg_height ~= .wrap
        scanResultLayout.tg_top ~= 23
        scanResultLayout.tg_horzMargin(Dimen.mainHorzMargin.rawValue)
        scanResultLayout.tg_padding = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)

        scanResultLayout.tg_visibility = .gone
        self.scanResultLayout = scanResultLayout

        initUserLayout(scanResultLayout)
        initUserResultLayout(scanResultLayout)

        rootLayout.addSubview(scanResultLayout)
    }

    func initUserLayout(_ rootLayout: TGLinearLayout) {
        let userLayout = TGLinearLayout(.vert)
        userLayout.tg_width ~= .fill
        userLayout.tg_height ~= .wrap
        userLayout.tg_visibility = .gone
        self.userLayout = userLayout
        rootLayout.addSubview(userLayout)

        let accountResultLabel = UILabel.makeTitleLabel("账户名   ", to: userLayout)
        accountResultLabel.tg_size(width: .fill, height: .wrap)
        checkedAccountNameLabel = accountResultLabel

        let ticketResultLabel = UILabel.makeTitleLabel("票张数   ", to: userLayout)
        ticketResultLabel.tg_size(width: .fill, height: .wrap)
        ticketResultLabel.tg_top ~= 7
        checkedTicketAmountLabel = ticketResultLabel

        let userButton = UIButton.makeFormButton("使用", to: userLayout)
        userButton.addTarget(self, action: #selector(userButtonClicked), for: .touchUpInside)
        userButton.tg_width ~= .fill
        userButton.tg_height ~= 40
        userButton.tg_top ~= 20
    }

    func initUserResultLayout(_ rootLayout: TGLinearLayout) {
        let userResultLayout = TGRelativeLayout()
        userResultLayout.tg_width ~= .fill
        userResultLayout.tg_height ~= .wrap
        userResultLayout.tg_visibility = .gone
        self.userResultLayout = userResultLayout
        rootLayout.addSubview(userResultLayout)

        let userResultImageView = UIImageView()
        userResultImageView.tg_width ~= .wrap
        userResultImageView.tg_height ~= .wrap
        userResultImageView.tg_centerY ~= 0
        userResultImageView.tg_right ~= 0
        self.userResultImageView = userResultImageView
        userResultLayout.addSubview(userResultImageView)

        let userResultLabel = UILabel.makeDescLabel("", to: userResultLayout)
        userResultLabel.numberOfLines = 0
        userResultLabel.tg_centerY ~= 0
        userResultLabel.tg_height ~= .wrap
        userResultLabel.tg_width ~= .wrap
        userResultLabel.tg_right ~= userResultImageView.tg_left
        userResultLabel.tg_left ~= 0
        self.userResultLabel = userResultLabel
        userResultLayout.addSubview(userResultLabel)


    }
}
