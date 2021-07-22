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
    var didTapConfirmAddres: ((String?,Int?,Int?,Int?) -> Void)?
    
    let customView: ManualLocationView = ManualLocationView.loadFromNib()
    let viewModel:ManualLocationViewModel = ManualLocationViewModel()
    
    private var buildingSelected: BuildingsModel?
    private var sectorSelected: SectorModel?
    private var subsectorSelected: SubsectorModel?
    
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
            self?.getBuildings()
        }
        
        customView.didTapSecondAddress = { [weak self] in
            self?.getSector()
        }
        
        customView.didTapThirdAddress = { [weak self] in
            self?.getSubsector()
        }
        
        customView.didTapConfirmAddress = { [weak self] (model) in
            self?.sendAddressAndIds(model)
        }
        
        viewModel.listBuildings = { [weak self] (buildings) in
            self?.goToFirstOptions(buildings)
        }
        
        viewModel.listSectors = { [weak self] (sectors) in
            self?.goToSecondOptions(sectors: sectors)
        }
        
        viewModel.listSubsectors = { [weak self] (subsectors) in
            self?.goToThirdOptions(subsectors: subsectors)
        }
    }
    
    private func sendAddressAndIds(_ model: String?) {
        var buildingID: Int? = nil
        var sectorID: Int? = nil
        var subsectorID: Int? = nil
        
        if let buildingModel = buildingSelected {
            if let id = buildingModel.id {
                buildingID = id
            }
        }
        
        if let secotrModel = sectorSelected {
            if let id = secotrModel.id {
                sectorID = id
            }
        }
        
        if let subsecotrModel = subsectorSelected {
            if let id = subsecotrModel.id {
                subsectorID = id
            }
        }
        didTapConfirmAddres?(model,buildingID,sectorID,subsectorID)
    }
    
    private func getBuildings() {
        viewModel.getBuildings()
    }
    
    private func getSector() {
        guard let buildingId = buildingSelected?.id else {return}
        viewModel.getSector(buildingID: buildingId)
    }
    
    private func getSubsector(){
        guard let sectorId = sectorSelected?.id else {return}
        viewModel.getSubsector(sectorID: sectorId)
    }
    
    private func goToFirstOptions(_ buildings: ListBuildingsModel?){
        let vc = SheetOptionsViewController(option: .buildings, model: viewModel.getModelForFirst())
        vc.modalPresentationStyle = .formSheet
        vc.didSelectBuidingItem = { [weak self] (item) in
            self?.buildingSelected = item
            self?.viewModel.insertFirstAddress(name: item.name ?? "")
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
    
    private func goToSecondOptions(sectors: ListSectorsModel?){
        let vc = SheetOptionsViewController(option: .sector, model: viewModel.getModelForSecond())
        vc.modalPresentationStyle = .formSheet
        vc.didSelectSectorItem = { [weak self] (item) in
            self?.sectorSelected = item
            self?.viewModel.insertSecondAddress(name: item.name ?? "")
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
    
    private func goToThirdOptions(subsectors: ListSubsectorsModel?){
        let vc = SheetOptionsViewController(option: .subsector, model: viewModel.getModelForThird())
        vc.modalPresentationStyle = .formSheet
        vc.didSelectSubsectorItem = { [weak self] (item) in
            self?.subsectorSelected = item
            self?.viewModel.insertThirdAddress(name: item.name ?? "")
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
}
