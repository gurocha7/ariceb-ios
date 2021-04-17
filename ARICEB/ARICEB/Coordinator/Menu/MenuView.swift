//
//  MenuView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class MenuView: UIView, NibLoadable {
    var viewModel: MenuViewModel?
    
//    @IBOutlet weak var headerView: HeaderMenuView!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        self.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 0.85)
//        headerView = HeaderMenuView.loadFromNib()
        tableView.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 0.85)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 55
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(cellType: SideMenuTableViewCell.self)
    }
    
    func reloadData(){
        tableView.reloadData()
    }

}

extension MenuView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.getItemForIndex(index: indexPath.row) else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.setupTitle(title: item)
        return cell
    }
}
