//
//  RotatePhoneViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 27/07/21.
//

import UIKit

class RotatePhoneViewController: UIViewController {

    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBAction func buttonCloseAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
    }

}
