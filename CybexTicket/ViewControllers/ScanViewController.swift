//
//  ScanViewController.swift
//  EOS
//
//  Created peng zhu on 2018/7/16.
//  Copyright © 2018年 com.nbltrust. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class ScanViewController: UIViewController {
    var preView: ScanPreviewView?
    var titleLabel: UILabel?
    var subTitle: String?
    var captusession: AVCaptureSession?
    var viewSize: CGSize!

	override func viewDidLoad() {
        super.viewDidLoad()
        viewSize = self.view.bounds.size
        setupUI()
        checkCameraAuth()
    }

    func checkCameraAuth() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            if status == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video) {[weak self] (_) in
                    guard let `self` = self else { return }
                    self.loadScanView()
                }
            } else if status == .authorized {
                self.loadScanView()
            } else { // 请授权
                self.loadScanView()
            }
        } else { //不支持camera
            self.loadScanView()

        }
    }

    func loadScanView() {
        initSession()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setupUI() {
        self.view.backgroundColor = UIColor.black
        let rect = ScanSetting.scanRect
        titleLabel = UILabel.init(frame: CGRect(x: 0, y: rect.maxY + 29, width: self.view.width, height: 20))
        if let label = titleLabel {
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = subTitle
            self.view.addSubview(label)
        }
    }

    func setupPreviewLayer() {
        preView = ScanPreviewView.init(frame: self.view.bounds)
        if let previewView = preView {
            previewView.session = captusession
            self.view.layer.insertSublayer(previewView.layer, at: 0)
        }
    }

    func initSession() {
        DispatchQueue.global().async {
            let session = AVCaptureSession()
            session.sessionPreset = .high
            self.addInput(session)
            self.addOutput(session, size: self.viewSize)
            session.startRunning()

            DispatchQueue.main.async {
                self.captusession = session
                self.setupPreviewLayer()
//                self.endLoading()
            }
        }

    }

    func addInput(_ session: AVCaptureSession) {
        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                try session.addInput(AVCaptureDeviceInput.init(device: captureDevice))
            } catch let error as NSError {
                Log.print(error)
            }
        }
    }

    func addOutput(_ session: AVCaptureSession, size: CGSize) {
        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)

            let rect = ScanSetting.scanRect
            output.rectOfInterest = CGRect(x: rect.origin.y / size.height, y: rect.origin.x / size.width, width: rect.size.height / size.height, height: rect.size.width / size.width)
            output.metadataObjectTypes = output.availableMetadataObjectTypes
            output.setMetadataObjectsDelegate(self as AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)
        }
    }

}

extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            if let obj: AVMetadataMachineReadableCodeObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject,
                let result = obj.stringValue {

            }
        }
    }
}
