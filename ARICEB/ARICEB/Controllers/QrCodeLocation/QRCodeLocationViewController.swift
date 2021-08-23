//
//  QRCodeLocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import AVFoundation

class QRCodeLocationViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private var viewModel: QRCodeLocationViewModel
    
    private var originLocation: QRCodeLocationModel?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Escaneie um QrCode"
        bindEvents()
        view.backgroundColor = .black
        captureSession = AVCaptureSession()
        captureVideo()
        configSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    init(viewModel: QRCodeLocationViewModel = QRCodeLocationViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    private func bindEvents() {
        viewModel.shouldShowError = {[weak self] (errorMSG) in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.showAlertWithMessage(message: errorMSG)
            }
        }
        
        viewModel.showQrcode = {[weak self] (location) in
            self?.originLocation = location
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.showSelectTravel()
            }
        }
    }
    
    func showSelectTravel(){
        let vc = SelectOriginDestinyViewController(isFromQrCode: true, locationModel: originLocation)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func captureVideo() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
    }
    
    private func configSession() {
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        DispatchQueue.main.async {
            self.playLoading()
            self.viewModel.getSteps(qrCode: code)
        }
    }
}
