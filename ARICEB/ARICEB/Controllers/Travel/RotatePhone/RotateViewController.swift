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
    
    //MARK: - Outlets
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    
    //MARK: - Actions
    @IBAction func buttonCloseAction(_ sender: Any) {
        dismiss(animated: true)
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
            // Configure a timer to fetch the motion data.
            self.timer = Timer(fire: Date(), interval: 5, repeats: true,
                               block: { (timer) in
                                if let data = self.managerMotion.deviceMotion {
                                    // Get the attitude relative to the magnetic north reference frame.
                                    debugPrint("==> DEGREES: ",data.heading)
                                    debugPrint("==============================")
                                    // Use the motion data in your app.
                                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
}
