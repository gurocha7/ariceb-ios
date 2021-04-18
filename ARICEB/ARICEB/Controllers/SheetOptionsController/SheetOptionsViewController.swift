//
//  SheetOptionsViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class SheetOptionsViewController: UIViewController  {

    var titleVC = "Selecione"
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var labelHeaderView: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    init(title: String?) {
        super.init(nibName: nil, bundle: nil)
        titleVC = title ?? "Selecione"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleVC
    }
    
    private func setup(){
        
    }

}
