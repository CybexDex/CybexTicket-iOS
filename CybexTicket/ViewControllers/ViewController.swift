//
//  ViewController.swift
//  CybexTicket
//
//  Created by koofrank on 2019/1/7.
//  Copyright © 2019 com.nbltrustdev. All rights reserved.
//

import UIKit
import TangramKit

class ViewController: UIViewController {
    
    weak var scanButton: UIButton!
    weak var accountTextField: UITextField!
    weak var ticketTextField: UITextField!
    weak var scanResultLayout: TGLinearLayout!
    weak var userLayout: TGLinearLayout!
    weak var userResultLayout: TGFrameLayout!
    weak var userResultLabel: UILabel!
    weak var userResultImageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.barTintColor = .yellow
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Cybex验票终端"
        
        let rootLayout = TGLinearLayout(.vert)
        rootLayout.backgroundColor = .yellow
        rootLayout.tg_width ~= .fill
        rootLayout.tg_height ~= .fill
        self.view = rootLayout
        self.edgesForExtendedLayout = UIRectEdge(rawValue:0)
        
        initScanLayout(rootLayout)
        initScanResultLayout(rootLayout);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func updateScanButtonState() {
        let account = self.accountTextField.text ?? ""
        let ticket = self.ticketTextField.text ?? ""
        self.scanButton.isEnabled = account.count > 0 && ticket.count > 0
    }
    
    @objc func scanButtonClicked() {
        //扫描逻辑处理 ...
        
        showScanResult(false)
    }
    
    @objc func userButtonClicked() {
        //使用逻辑处理 ...
        
        showUserResult(true)
    }
    
    /**
     * @param isInvalid 是否有效 true无效 false有效
     */
    func showScanResult(_ isInvalid: Bool) {
        self.scanResultLayout.tg_visibility = .visible
        if (isInvalid) {
            showUserResult(isInvalid)
        } else {
            self.userLayout.tg_visibility = .visible
        }
    }
    
    /**
     * @param isInvalid 是否有效 true无效 false有效
     */
    func showUserResult(_ isInvalid: Bool) {
        self.userLayout.tg_visibility = .gone
        self.userResultLayout.tg_visibility = .visible
        self.userResultLabel.text = isInvalid ? "非常抱歉，您使用的是无效票，请重新扫码！" : "恭喜您，您的票验证通过，已使用成功！"
        self.userResultImageView.image = isInvalid ? R.image.icInvalidTicket() : R.image.icUsedTicket()
    }
    
    func initScanLayout(_ rootLayout: TGLinearLayout) {
        let scanLayout = TGLinearLayout(.vert)
        scanLayout.tg_width ~= .fill
        scanLayout.tg_height ~= .wrap
        scanLayout.tg_top ~= 23
        scanLayout.tg_left ~= 20
        scanLayout.tg_right ~= 20
        scanLayout.tg_topPadding = 30
        scanLayout.tg_bottomPadding = 30
        scanLayout.tg_leftPadding = 20
        scanLayout.tg_rightPadding = 20
        scanLayout.backgroundColor = .white
        scanLayout.layer.cornerRadius = 4
        scanLayout.layer.masksToBounds = true
        scanLayout.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        let accountLabel = UILabel()
        accountLabel.text = "验证账户"
        accountLabel.textColor = .steel
        accountLabel.font = UIFont.systemFont(ofSize: 14)
        accountLabel.sizeToFit()
        
        let accountTextField = UITextField()
        accountTextField.font = UIFont.boldSystemFont(ofSize: 16)
        accountTextField.textColor = .darkTwo
        accountTextField.placeholder = "请输入验证账户"
        accountTextField.tg_top ~= 7
        accountTextField.sizeToFit()
        accountTextField.addTarget(self, action: #selector(updateScanButtonState), for: .editingChanged)
        self.accountTextField = accountTextField
        
        let divider_account = UIView();
        divider_account.tg_width ~= .fill
        divider_account.tg_height ~= 1;
        divider_account.backgroundColor = .paleGrey
        divider_account.tg_top ~= 7;
        
        let ticketLabel = UILabel()
        ticketLabel.text = "票名称"
        ticketLabel.textColor = .steel
        ticketLabel.tg_top ~= 14
        ticketLabel.font = UIFont.systemFont(ofSize: 14)
        ticketLabel.sizeToFit()
        
        let ticketTextField = UITextField()
        ticketTextField.font = UIFont.boldSystemFont(ofSize: 16)
        ticketTextField.textColor = .darkTwo
        ticketTextField.placeholder = "请输入票名称"
        ticketTextField.tg_top ~= 7
        ticketTextField.sizeToFit()
        ticketTextField.addTarget(self, action: #selector(updateScanButtonState), for: .editingChanged)
        self.ticketTextField = ticketTextField
        
        
        let divider_ticket = UIView();
        divider_ticket.tg_width ~= .fill
        divider_ticket.tg_height ~= 1;
        divider_ticket.backgroundColor = .paleGrey
        divider_ticket.tg_top ~= 7;
        
        let scanButton = UIButton()
        scanButton.tg_width ~= .fill
        scanButton.tg_height ~= 40
        scanButton.tg_top ~= 20
        scanButton.setTitle("扫码", for: .normal)
        scanButton.titleColorForNormal = .white
        scanButton.setBackgroundImage(R.image.btnColorOrange(), for: .normal)
        scanButton.setBackgroundImage(R.image.btnColorGrey(), for: .disabled)
        scanButton.isEnabled = false
        scanButton.addTarget(self, action: #selector(scanButtonClicked), for: .touchUpInside)
        self.scanButton = scanButton
        
        scanLayout.addSubview(accountLabel)
        scanLayout.addSubview(accountTextField)
        scanLayout.addSubview(divider_account)
        scanLayout.addSubview(ticketLabel)
        scanLayout.addSubview(ticketTextField)
        scanLayout.addSubview(divider_ticket)
        scanLayout.addSubview(scanButton)
        
        rootLayout.addSubview(scanLayout)
    }
    
    func initScanResultLayout(_ rootLayout: TGLinearLayout) {
        let scanResultLayout = TGLinearLayout(.vert)
        scanResultLayout.tg_width ~= .fill
        scanResultLayout.tg_height ~= .wrap
        scanResultLayout.tg_top ~= 23
        scanResultLayout.tg_left ~= 20
        scanResultLayout.tg_right ~= 20
        scanResultLayout.tg_topPadding = 30
        scanResultLayout.tg_bottomPadding = 30
        scanResultLayout.tg_leftPadding = 20
        scanResultLayout.tg_rightPadding = 20
        scanResultLayout.backgroundColor = .white
        scanResultLayout.layer.cornerRadius = 4
        scanResultLayout.layer.masksToBounds = true
        scanResultLayout.layer.shadowOffset = CGSize(width: 4, height: 4)
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
        
        let accountResultLabel = UILabel()
        accountResultLabel.text = "账户名   Cybex-test"
        accountResultLabel.textColor = .darkTwo
        accountResultLabel.font = UIFont.systemFont(ofSize: 14)
        accountResultLabel.sizeToFit()
        
        let ticketResultLabel = UILabel()
        ticketResultLabel.text = "票张数   1"
        ticketResultLabel.textColor = .darkTwo
        ticketResultLabel.font = UIFont.systemFont(ofSize: 14)
        ticketResultLabel.tg_top ~= 7;
        ticketResultLabel.sizeToFit()
        
        let userButton = UIButton()
        userButton.tg_width ~= .fill
        userButton.tg_height ~= 40
        userButton.tg_top ~= 20
        userButton.setTitle("使用", for: .normal)
        userButton.titleColorForNormal = .white
        userButton.setBackgroundImage(R.image.btnColorOrange(), for: .normal)
        userButton.addTarget(self, action: #selector(userButtonClicked), for: .touchUpInside)
        
        userLayout.addSubview(accountResultLabel)
        userLayout.addSubview(ticketResultLabel)
        userLayout.addSubview(userButton)
        rootLayout.addSubview(userLayout)
    }
    
    func initUserResultLayout(_ rootLayout: TGLinearLayout) {
        let userResultLayout = TGFrameLayout()
        userResultLayout.tg_width ~= .fill
        userResultLayout.tg_height ~= .wrap
        userResultLayout.tg_visibility = .gone
        self.userResultLayout = userResultLayout;
        
        let userResultLabel = UILabel()
        userResultLabel.tg_width ~= 176
        userResultLabel.tg_height ~= .wrap
        userResultLabel.textColor = .darkTwo
        userResultLabel.numberOfLines = 2
        userResultLabel.tg_centerY ~= 0
        userResultLabel.font = UIFont.systemFont(ofSize: 14)
        self.userResultLabel = userResultLabel
        
        let userResultImageView = UIImageView()
        userResultImageView.tg_width ~= .wrap
        userResultImageView.tg_height ~= .wrap
        userResultImageView.tg_centerY ~= 0
        userResultImageView.tg_right ~= 10
        self.userResultImageView = userResultImageView
        
        userResultLayout.addSubview(userResultLabel)
        userResultLayout.addSubview(userResultImageView)
        rootLayout.addSubview(userResultLayout)
    }

}

