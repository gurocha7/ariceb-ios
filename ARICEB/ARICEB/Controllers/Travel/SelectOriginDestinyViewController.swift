//
//  SelectOriginDestinyViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit
import Alamofire

class SelectOriginDestinyViewController: BaseViewController {
    
    let customView: SelectOriginDestinyView = SelectOriginDestinyView.loadFromNib()
    let viewModel:  SelectOriginDestinyViewModel = SelectOriginDestinyViewModel()
    
    override func loadView() {
        super.loadView()
        title = "Caminho"
        view = customView
        customView.viewModel = self.viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
    }
    
    private func bindEvents(){
        customView.shouldSelectOrigin = { [weak self] in
            self?.showLocation()
        }
        
        customView.shouldEditOrigin = {[weak self] in
            self?.editOrigin()
        }
        
        customView.shouldSelectDestiny = { [weak self] in
            self?.editDestiny()
        }
        
        customView.shouldEditDestiny = { [weak self] in
            self?.editDestiny()
        }
        
        customView.shouldShowTravelLive = { [weak self] in
            self?.showTravelLive()
        }
        
        viewModel.updateOriginLayout = { [weak self] in
            self?.customView.updateOriginLayout()
        }
        
        viewModel.updateDestinyLayout = { [weak self] in
            self?.customView.updateDestinyLayout()
        }
    }
    
    private func editOrigin(){
        let vc = ManualLocationViewController(isOrigin: true)
        vc.didTapConfirmAddres = { [weak self] (model) in
            guard self != nil else {return}
            self?.viewModel.insertModelOrigin(model: model)
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func editDestiny(){
        let vc = ManualLocationViewController(isOrigin: false)
        vc.didTapConfirmAddres = { [weak self] (model) in
            guard self != nil else {return}
            self?.viewModel.insertModelDestiny(model: model)
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showLocation(){
        let vc = LocationViewController()
        vc.didTapConfirmAddres = { [weak self] (model) in
            guard self != nil else {return}
            self?.viewModel.insertModelOrigin(model: model)
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showTravelLive() {
        let controller = TravelLiveViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    private func getRouteTest() {
        AF.request("http://127.0.0.1:3000/v1/internalroute", method: .get, parameters: nil).responseJSON { response in
            print("###RESPONSE: ",response)
            guard let data = response.data else {return}
            do {
                print("DEU BOM!")
            }catch {
                print("DEU RUIM!")
            }
        }
    }
    
}
