//
//  BaseViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    
    var loading: AnimationView = AnimationView()
    var blurEffectView: UIVisualEffectView!
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLoading()
    }

    func setupNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                     style: .plain,
                                                                     target: nil,
                                                                     action: nil)
    }
    
    func setupLoading() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        loading.animation = Animation.named("mainLoading")
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.contentMode = .scaleAspectFit
        view.addSubview(loading)
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blurEffectView.isHidden = true
        loading.isHidden = true
    }
    
    func playLoading() {
        loading.isHidden = false
        blurEffectView.isHidden = false
        loading.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
    
    func stopLoading() {
        loading.isHidden = true
        blurEffectView.isHidden = true
        loading.stop()
    }
}
