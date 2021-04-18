//
//  SheetOptionsViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class SheetOptionsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    enum SheetOptions{
        case buildings
        case sector
        case subsector
    }

    var typeSheet: SheetOptions = .buildings
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var labelHeaderView: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func buttonCloseAction(_ sender: Any) {
        dismissSheet?()
    }
    
    var didSelectItem: ((String) -> Void)?
    var dismissSheet: (() -> Void)?
    var items: [String] = []
    
    init(option: SheetOptions = .buildings, model: [String]) {
        super.init(nibName: nil, bundle: nil)
        typeSheet = option
        items = model
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
        tableView.separatorStyle = .none
        tableView.applyCorner(corner: 15)
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
        let item = items[indexPath.row]
        didSelectItem?(item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

}
