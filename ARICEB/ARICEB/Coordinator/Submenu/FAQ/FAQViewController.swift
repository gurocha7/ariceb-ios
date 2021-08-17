//
//  FAQViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: FAQViewModel = FAQViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FAQ"
        setup()
    }
    
    private func setup(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.register(cellType: FAQTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        choiceFQA(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfQuestions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
        cell.setupInfo(question: viewModel.getItemAtIndex(index: indexPath.row))
        return cell
    }
    
    private func choiceFQA(index: Int) {
        switch index {
        case 0:
            showFAQDetails()
        case 1:
            showFAQDetails2()
        case 2:
            showFAQDetails3()
        default:
            break
        }
    }
    
    func showFAQDetails() {
        let controler = FAQDetailsViewController()
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func showFAQDetails2() {
        let controler = FAQDetails2ViewController()
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func showFAQDetails3() {
        let controler = FAQDetails3ViewController()
        navigationController?.pushViewController(controler, animated: true)
    }
}
