//
//  SelectBuildingViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 23/08/21.
//

import UIKit
import Alamofire

class SelectBuildingViewController: UIViewController {
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var buttonBuilding: UIButton!
    
    @IBAction func buttonBuildingAction(_ sender: Any) {
        showBuildingsOptions()
    }
    
    @IBAction func buttonConfirmAction(_ sender: Any) {
        guard let destinyBuilding = buildingDestiny else {return}
        let route = ExternalRoute(buildingDestiny: destinyBuilding, buildingOrigin: BuildingsModel(id: 0, name: "",
                                                                                                   lat: originLat,
                                                                                                   long: originLong))
        showExternalTravelLive(route: route)
    }
    
    var buildingDestiny: BuildingsModel?
    var originLat: Double = 0.0
    var originLong: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selecione o destino"
        setupUI()
        bindEvents()
    }
    
    func setLatAndLong(lat: Double,long: Double) {
        originLat = lat
        originLong = long
    }
    
    private func setupUI() {
        buttonConfirm.applyCorner(corner: 10)
        buttonBuilding.applyCorner(corner: 10)
        buttonBuilding.applyBorder(borderWidth: 1, borderColor: UIColor.gray.cgColor)
    }
    
    private func showExternalTravelLive(route: ExternalRoute) {
        let controller = TravelLiveViewController()
        controller.setupExternalRoute(route: route)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func bindEvents() {
        
    }
    
    private func showBuildingsOptions() {
        getBuildings()
    }
    
    func getBuildings() {
        print("###URL: \(baseURL)/buildings")
        AF.request("\(baseURL)/buildings", method: .get).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                let model = try JSONDecoder().decode(ListBuildingsModel.self, from: data)
                DispatchQueue.main.async {
                    self.goToFirstOptions(model)
                }
            }catch {
                DispatchQueue.main.async {
                    self.showAlertWithMessage(message: "Ocorreu um erro inesperado, tente novamente mais tarde.")
                }
            }
        }
    }
    
    private func goToFirstOptions(_ buildings: ListBuildingsModel?){
        guard let buildingsArray = buildings?.buildings else {return}
        let vc = SheetOptionsViewController(option: .buildings, model: buildingsArray)
        vc.modalPresentationStyle = .formSheet
        vc.didSelectBuidingItem = { [weak self] (item) in
            self?.buildingDestiny = item
            DispatchQueue.main.async {
                self?.buttonBuilding.setTitle(self?.buildingDestiny?.name, for: .normal)
            }
            vc.dismiss(animated: true, completion: nil)
        }
        vc.dismissSheet = {
            vc.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    private func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
