//
//  FAQDetailsViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 08/08/21.
//

import UIKit

class FAQDetailsViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var stack: UIStackView!
    
    private var viewModel: FAQDetailsViewModel = FAQDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()

    }

    private func setupNav() {
        title = "COMO USAR O APP?"
    }
    
}
