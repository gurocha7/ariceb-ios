//
//  SubmenuViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import UIKit

class SubmenuViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var viewModel: SubmenuViewModel = SubmenuViewModel()
    var option: String?
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    init(option: String) {
        super.init(nibName: nil, bundle: nil)
        self.option = option
        self.title = option.capitalized
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
        tableView.backgroundColor = .white
        tableView.rowHeight = 70
        tableView.register(cellType: SubmenuTableViewCell.self)
        tableView.applyBorder(borderWidth: 0.5, borderColor: UIColor.darkGray.cgColor)
        searchBar.delegate = self
        searchBar.placeholder = "Procurar"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmenuTableViewCell", for: indexPath) as! SubmenuTableViewCell
        cell.setupInfo(name: "row \(indexPath.row)")
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
