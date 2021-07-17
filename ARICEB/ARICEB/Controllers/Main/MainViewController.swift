//
//  MainViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 14/02/21.
//

import UIKit
import Alamofire

class MainViewController: BaseViewController {
    
    //MARK: - Properties
    
    var coordinator: MainCoordinator?
    
    @IBOutlet weak var stackView: UIStackView!
    
    let travelView: TravelView = TravelView.loadFromNib()
    let bannerView: BannerView = BannerView.loadFromNib()
    let qrCodeView: QRCodeView = QRCodeView.loadFromNib()
    let fastButtonsView: FastButtonsView = FastButtonsView.loadFromNib()
    
    
    var selectOriginAndDestiny: (()-> Void)?
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getRouteTest()
    }
    
    //MARK: - Methods
    
    private func setup(){
        title = "ARICEB"
        navigationController?.navigationBar.barTintColor = mainColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        view.backgroundColor = .white
        setupStack()
        bindEvents()
    }
    
    private func bindEvents(){
        travelView.selectOriginAndDestiny = { [weak self] in
            self?.selectOriginAndDestiny?()
        }
    }
    
    private func setupStack(){
        setupTravelView()
        setupBannerView()
        setupQrCodeView()
        setupFastButtonsView()
    }
    
    private func setupTravelView(){
        travelView.translatesAutoresizingMaskIntoConstraints = false
        travelView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        stackView.addArrangedSubview(travelView)
    }
    
    private func setupBannerView(){
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        stackView.addArrangedSubview(bannerView)
    }
    
    private func setupQrCodeView(){
        qrCodeView.translatesAutoresizingMaskIntoConstraints = false
        qrCodeView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.addArrangedSubview(qrCodeView)
    }
    
    private func setupFastButtonsView(){
        fastButtonsView.translatesAutoresizingMaskIntoConstraints = false
        fastButtonsView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.addArrangedSubview(fastButtonsView)
    }
    
    private func getRouteTest() {
        AF.request("http://127.0.0.1:3000/v1/internalroute", method: .get, parameters: nil).responseJSON { response in
            print("###RESPONSE: ",response)
            guard let data = response.data else {return}
            do {
                print("DEU BOM!")
            }catch {
                print("DEU RUIM!")
            }
        }
    }
}
