//
//  SubmenuViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import UIKit

class SubmenuViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    enum SubmenuTypeController: String{
        case classes = "aulas"
        case buldings = "prédios"
        case bathroom = "banheiros"
        case department = "departamentos"
        case auditoriums = "auditórios"
        case laboratories = "laboratórios"
    }
    
    var typeController: SubmenuTypeController = .classes
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
        setupDescription()
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
    
    private func setupDescription(){
        guard let _option = option else {return}
        switch _option.lowercased() {
        case SubmenuTypeController.classes.rawValue:
            viewModel.typeModel = .classes
            typeController = .classes
            labelTitle.text = viewModel.getClassesDescription()
        case SubmenuTypeController.buldings.rawValue:
            viewModel.typeModel = .buldings
            typeController = .buldings
            labelTitle.text = viewModel.getBuildingsDescription()
        case SubmenuTypeController.bathroom.rawValue:
            viewModel.typeModel = .bathroom
            typeController = .bathroom
            labelTitle.text = viewModel.getBathroomsDescription()
        case SubmenuTypeController.department.rawValue:
            viewModel.typeModel = .department
            typeController = .department
            labelTitle.text = viewModel.getDepartmentDescription()
        case SubmenuTypeController.auditoriums.rawValue:
            viewModel.typeModel = .auditoriums
            typeController = .auditoriums
            labelTitle.text = viewModel.getAuditoriumDescription()
        case SubmenuTypeController.laboratories.rawValue:
            viewModel.typeModel = .laboratories
            typeController = .laboratories
            labelTitle.text = viewModel.getLaboratoriesDescription()
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfModels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmenuTableViewCell", for: indexPath) as! SubmenuTableViewCell
        cell.setupInfo(name: viewModel.getItemAtIndex(index: indexPath.row))
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
