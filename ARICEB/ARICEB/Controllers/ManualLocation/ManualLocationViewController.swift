//
//  ManualLocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import FittedSheets

class ManualLocationViewController: BaseViewController {
    
    var isOrigin: Bool = false
    
    let customView: ManualLocationView = ManualLocationView.loadFromNib()
    let viewModel:ManualLocationViewModel = ManualLocationViewModel()
    
    init(isOrigin: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.isOrigin = isOrigin
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        title = isOrigin ? "Origem" : "Destino"
        view = customView
        customView.viewModel = self.viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.setupPlaceholders()
        bindEvents()
    }
    
    private func bindEvents(){
        customView.didTapFirstAddress = { [weak self] in
            self?.goToFirstOptions()
        }
        
        customView.didTapSecondAddress = { [weak self] in
            self?.goToSecondOptions()
        }
        
        customView.didTapThirdAddress = { [weak self] in
            self?.goToThirdOptions()
        }
    }
    
    private func goToFirstOptions(){
        let vc = SheetOptionsViewController(option: .buildings, model: viewModel.getModelForFirst())
        vc.modalPresentationStyle = .formSheet
        vc.didSelectItem = { [weak self] (item) in
            self?.viewModel.insertFirstAddress(name: item)
            DispatchQueue.main.async {
                self?.customView.updateLayoutWithModel()
            }
            vc.dismiss(animated: true, completion: nil)
        }
        vc.dismissSheet = {
            vc.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    private func goToSecondOptions(){
        
    }
    
    private func goToThirdOptions(){
        
    }
    
    private func updateLayout(){
        
    }

}
