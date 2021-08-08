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
    
    private var index: Int = 0
    
    init(_ index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupInfoFor()
    }

    private func setupNav() {
        title = viewModel.getTitleFor(index)
    }
    
    private func setupInfoFor() {
        labelTitle.text = viewModel.getDescriptionFor(index)
        let imageName = viewModel.getDescriptionNameImageFor(index)
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        image.contentMode = .scaleAspectFill
        image.heightAnchor.constraint(equalToConstant: 130).isActive = true
        clearStack()
        stack.addArrangedSubview(image)
    }
    
    private func clearStack() {
        stack.arrangedSubviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
    
}
