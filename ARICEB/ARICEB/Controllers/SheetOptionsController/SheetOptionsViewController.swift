//
//  SheetOptionsViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class SheetOptionsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    enum SheetOptions{
        case buildings
        case sector
        case subsector
    }

    var typeSheet: SheetOptions = .buildings
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var labelHeaderView: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func buttonCloseAction(_ sender: Any) {
        dismissSheet?()
    }
    
    var didSelectBuidingItem: ((BuildingsModel) -> Void)?
    var didSelectSectorItem: ((SectorModel) -> Void)?
    var didSelectSubsectorItem: ((SubsectorModel) -> Void)?
    var dismissSheet: (() -> Void)?
    
    var items: [BuildingsModel] = []
    var sectorItems: [SectorModel] = []
    var subsectorItems: [SubsectorModel] = []
    
    init(option: SheetOptions = .buildings, model: [BuildingsModel]) {
        super.init(nibName: nil, bundle: nil)
        typeSheet = option
        items = model
    }
    
    init(option: SheetOptions = .sector, model: [SectorModel]) {
        super.init(nibName: nil, bundle: nil)
        typeSheet = option
        sectorItems = model
    }
    
    init(option: SheetOptions = .subsector, model: [SubsectorModel]) {
        super.init(nibName: nil, bundle: nil)
        typeSheet = option
        subsectorItems = model
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        buttonClose.setImage(UIImage(named: "icon-close")?.withRenderingMode(.alwaysOriginal), for: .normal)
        labelHeaderView.text = getTitle()
    }
    
    private func getTitle() -> String{
        switch typeSheet {
        case .buildings:
            return "Selecione o prédio"
        case .sector:
            return "Selecione o ambiente"
        case .subsector:
            return "Selecione o local"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch typeSheet {
        case .buildings:
            let item = items[indexPath.row]
            didSelectBuidingItem?(item)
        case .sector:
            let item = sectorItems[indexPath.row]
            didSelectSectorItem?(item)
        case .subsector:
            let item = subsectorItems[indexPath.row]
            didSelectSubsectorItem?(item)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch typeSheet {
        case .buildings:
            return items.count
        case .sector:
            return sectorItems.count
        case .subsector:
            return subsectorItems.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch typeSheet {
            case .buildings:
                cell.textLabel?.text = items[indexPath.row].name
            case .sector:
                cell.textLabel?.text = sectorItems[indexPath.row].name
            case .subsector:
                cell.textLabel?.text = subsectorItems[indexPath.row].name
        }
        return cell
    }
}
