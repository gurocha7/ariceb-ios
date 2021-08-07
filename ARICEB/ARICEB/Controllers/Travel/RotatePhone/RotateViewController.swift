//
//  RotateViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 28/07/21.
//

import UIKit
import CoreMotion
import CoreLocation

class RotateViewController: UIViewController,CLLocationManagerDelegate {
    //MARK: - Properties
    private var managerMotion: CMMotionManager = CMMotionManager()
    
    private var timer: Timer!
    private var firstPosition: Double = 0.0
    let rotateDegrees: Double = 80
    var needRotateToRight: Bool = false
    var dismissRotate: (() -> Void)?
    var shouldShowStep: (() -> Void)?
    
    var firstValueRange: Double = 0.0
    var lastValueRange: Double = 0.0
    
    var extraFirstValueRange: Double = 0.0
    var extraLastValueRange: Double = 0.0
    
    var isEspecialZone: Bool = false
    
    //MARK: - Outlets
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    //MARK: - Actions
    @IBAction func buttonCloseAction(_ sender: Any) {
        timer.invalidate()
        dismissRotate?()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        startDeviceMotion()
    }
        
    func startDeviceMotion() {
        labelMessage.text = needRotateToRight ? "Gire o iPhone para a direita"  :  "Gire o iPhone para a esquerda"
        animateArrow()
        if managerMotion.isDeviceMotionAvailable {
            self.managerMotion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.managerMotion.showsDeviceMovementDisplay = true
            self.managerMotion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            self.timer = Timer(fire: Date(), interval: 0.5, repeats: true,
                               block: { (timer) in
                                if let data = self.managerMotion.deviceMotion {
                                    // Get the attitude relative to the magnetic north reference frame.
//                                    debugPrint("==> DEGREES: ",data.heading)
//                                    debugPrint("==============================")
//                                    debugPrint("==> FIRST VALUE: ",self.firstPosition)
                                    if self.firstPosition == 0.0 {
                                        self.firstPosition = data.heading
                                        if self.firstPosition >= 90  && self.firstPosition <= 280 {
                                            self.firstValueRange = self.needRotateToRight ? (self.firstPosition + self.rotateDegrees) : (self.firstPosition - self.rotateDegrees - 10)
                                            self.lastValueRange = self.needRotateToRight ? (self.firstPosition + self.rotateDegrees + 10) : (self.firstPosition - self.rotateDegrees)
                                        }else if self.firstPosition >= 81 && self.firstPosition < 90 {
                                            self.isEspecialZone = true
                                            if self.needRotateToRight {
                                                self.firstValueRange = self.firstPosition + self.rotateDegrees
                                                self.lastValueRange = self.firstPosition + self.rotateDegrees + 10
                                            }else {
                                                self.firstValueRange = 0
                                                let restOfSub = self.firstPosition - self.rotateDegrees
                                                self.lastValueRange = restOfSub
                                                self.extraFirstValueRange = 360 - (10 - restOfSub)
                                                self.extraLastValueRange = 360
                                            }
                                        }
                                        else if self.firstPosition >= 0 && self.firstPosition <= 80 {
                                            self.firstValueRange = self.needRotateToRight ? (self.firstPosition + self.rotateDegrees) : (350 - (self.rotateDegrees - self.firstPosition ))
                                            self.lastValueRange = self.needRotateToRight ? (self.firstPosition + self.rotateDegrees + 10) : (360 - (self.rotateDegrees - self.firstPosition ))
                                        }else {
                                            self.firstValueRange = self.needRotateToRight ? (self.firstPosition + self.rotateDegrees - 360) : (self.firstPosition - self.rotateDegrees - 10)
                                            self.lastValueRange = self.needRotateToRight ? (self.firstPosition + self.rotateDegrees - 350) : (self.firstPosition - self.rotateDegrees)
                                        }
                                    }else {
                                        
                                        if self.isEspecialZone {
                                            if self.needRotateToRight {
                                                let range = self.firstValueRange...self.lastValueRange
                                                if range.contains(data.heading) {
//                                                    debugPrint("**PODE TRAÇAR A ROTA INTERNA PARA DIREITA**")
                                                    self.timer.invalidate()
                                                    self.shouldShowStep?()
                                                }
                                            }else {
                                                let range = self.firstValueRange...self.lastValueRange
                                                let secondRange = self.extraFirstValueRange...self.extraLastValueRange
                                                if range.contains(data.heading) || secondRange.contains(data.heading) {
//                                                    debugPrint("**PODE TRAÇAR A ROTA INTERNA PARA ESQUERDA**")
                                                    self.timer.invalidate()
                                                    self.shouldShowStep?()
                                                }
                                            }
                                        }else {
                                            let range = self.firstValueRange...self.lastValueRange
                                            if range.contains(data.heading) {
//                                                debugPrint("**PODE TRAÇAR A ROTA INTERNA PARA DIREITA**")
                                                self.timer.invalidate()
                                                self.shouldShowStep?()
                                            }
                                        }
                                    }
                                }
            })
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    private func animateArrow() {
        imgArrow.transform = needRotateToRight ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: .pi)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, delay: 0.0, options: [.repeat,.autoreverse]) {
                if self.needRotateToRight {
                    self.imgArrow.center.x += 100
                    self.imgArrow.center.x -= 100
                }else {
                    self.imgArrow.center.x -= 100
                    self.imgArrow.center.x += 100
                }
            }
        }
    }
    
    func setStepsAndParams(_ step: StepsModel?) {
        guard let stepValue = step else {return}
        guard let angle = stepValue.angle else {return}
        guard let direction = stepValue.rotatePhone else {return}
//        rotateDegrees = angle
        needRotateToRight = direction.lowercased() == "r"
    }
}
