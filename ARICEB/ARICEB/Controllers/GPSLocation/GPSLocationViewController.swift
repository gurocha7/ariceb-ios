//
//  GPSLocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 23/08/21.
//

import UIKit
import CoreData

class GPSLocationViewController: UIViewController {
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: Any) {
        getLatAndLong()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Origem"
        setupUI()
    }
    
    private func setupUI() {
        button.applyCorner(corner: 10)
    }
    
    private func getLatAndLong() {
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
            debugPrint(currentLocation.coordinate.longitude)
            debugPrint(currentLocation.coordinate.latitude)
            showSelectBuildingController()
        }
    }
    
    private func showSelectBuildingController() {
        let vc = SelectBuildingViewController()
        vc.setLatAndLong(lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
