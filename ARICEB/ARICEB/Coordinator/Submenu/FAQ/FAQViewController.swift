//
//  FAQViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FAQ"
        setup()
    }
    
    private func setup(){
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "row \(indexPath.row)"
        return cell
    }

}
