//
//  SheetOptionsViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class SheetOptionsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var titleVC = "Selecione"
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var labelHeaderView: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func buttonCloseAction(_ sender: Any) {
        dismissSheet?()
    }
    
    var dismissSheet: (() -> Void)?
    
    init(title: String?) {
        super.init(nibName: nil, bundle: nil)
        titleVC = title ?? "Selecione"
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        buttonClose.setImage(UIImage(named: "icon-close")?.withRenderingMode(.alwaysOriginal), for: .normal)
        labelHeaderView.text = titleVC
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "row \(indexPath.row)"
        return cell
    }

}
