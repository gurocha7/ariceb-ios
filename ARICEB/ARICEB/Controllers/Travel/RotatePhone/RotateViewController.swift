//
//  RotateViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 28/07/21.
//

import UIKit

class RotateViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    
    //MARK: - Actions
    @IBAction func buttonCloseAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
