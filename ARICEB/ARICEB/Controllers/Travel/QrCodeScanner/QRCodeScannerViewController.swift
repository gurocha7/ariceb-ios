//
//  QRCodeScannerViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 25/07/21.
//
import AVFoundation
import UIKit

class ScannerViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var showRouteByQrCode: ((NextStepsModel) -> Void)?
    
    var drawStepAtIndex: ((Int) -> Void)?
    private var existingSteps: [String]?
    private var viewModel: QRCodeScannerViewModel
    var tapCloseController: (() -> Void)?
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
     init(viewModel: QRCodeScannerViewModel = QRCodeScannerViewModel(),existingSteps: [String]? = nil) {
         self.viewModel = viewModel
         self.existingSteps = existingSteps
         super.init(nibName: nil, bundle: nil)
     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Escaneie um QrCode"
        bindEvents()
        setupNavBar()
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
    
    private func bindEvents() {
        viewModel.showSteps = { [weak self] (model) in
            self?.stopLoading()
            self?.invalidQRCodeTimer()
            UserDefaults.standard.setValue(true, forKey: "getQRCodeByAPI")
            self?.showRouteByQrCode?(model)
        }
        
        viewModel.shouldShowError = { [weak self] (errorMSG) in
            self?.stopLoading()
            self?.invalidQRCodeTimer()
        }
    }

    private func setupNavBar() {
        let closeButton = UIBarButtonItem(image: UIImage(named: "icon-close-black")?.withRenderingMode(.alwaysOriginal),
                                          style: .plain,
                                          target: self, action: #selector(didTapCloseButton))
        navigationItem.rightBarButtonItem = closeButton
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
    
    func insertDestinationTag(destinationTag: String?) {
        viewModel.insertDestinationTag(tag: destinationTag)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    @objc
    func UpdateTimer() {
        counter = counter + 0.1
    }
    
    private func invalidQRCodeTimer() {
        UserDefaults.standard.setValue(counter, forKey: "lastTimerForQrCode")
        timer.invalidate()
        isPlaying = false
    }

    func found(code: String) {
        playLoading()
        if let currentSteps = existingSteps {
            if currentSteps.contains(code) {
                let count = currentSteps.count - 1
                for i in 0...count {
                    if currentSteps[i] == code {
                        drawStepAtIndex?(i)
                        invalidQRCodeTimer()
                        UserDefaults.standard.setValue(false, forKey: "getQRCodeByAPI")
                        stopLoading()
                        return
                    }
                }
            }else{
                viewModel.getSteps(qrCode: code)
            }
        }else {
          viewModel.getSteps(qrCode: code)
        }
    }

    @objc
    func didTapCloseButton() {
        tapCloseController?()
    }
}
