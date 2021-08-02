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
    var rotateDegrees: Double = 80
    var needRotateToRight: Bool = false
    var dismissRotate: (() -> Void)?
    var shouldShowStep: (() -> Void)?
    
    //MARK: - Outlets
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    
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
        if managerMotion.isDeviceMotionAvailable {
            self.managerMotion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.managerMotion.showsDeviceMovementDisplay = true
            self.managerMotion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            self.timer = Timer(fire: Date(), interval: 1, repeats: true,
                               block: { (timer) in
                                if let data = self.managerMotion.deviceMotion {
                                    // Get the attitude relative to the magnetic north reference frame.
                                    debugPrint("==> DEGREES: ",data.heading)
                                    debugPrint("==============================")
                                    debugPrint("==> FIRST VALUE: ",self.firstPosition)
                                    if self.firstPosition == 0.0 {
                                        self.firstPosition = data.heading
                                    }else {
                                        if self.needRotateToRight {
                                            let motionRightResult = data.heading >= (self.firstPosition + self.rotateDegrees)
                                            if motionRightResult {
                                                debugPrint("**PODE TRAÇAR A ROTA INTERNA**")
                                                self.timer.invalidate()
                                                self.shouldShowStep?()
                                            }
                                        }else {
                                            let motionLeftResult = data.heading <= (self.firstPosition - self.rotateDegrees)
                                            if motionLeftResult {
                                                debugPrint("**PODE TRAÇAR A ROTA INTERNA**")
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
    
    func setStepsAndParams(_ step: StepsModel?) {
        guard let stepValue = step else {return}
        guard let angle = stepValue.angle else {return}
        guard let direction = stepValue.rotatePhone else {return}
        rotateDegrees = angle
        needRotateToRight = direction.lowercased() == "r"
    }
}
