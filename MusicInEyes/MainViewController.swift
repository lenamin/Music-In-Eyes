//
//  MainViewController.swift
//  MusicInEyes
//
//  Created by Lena on 2022/08/26.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var recordButton: UIButton = {
        let buttom = UIButton()

        buttom.backgroundColor = .customNavy
        buttom.layer.cornerRadius = (UIScreen.main.bounds.width * 0.2) / 2
        buttom.layer.masksToBounds = false
        buttom.layer.shadowRadius = 7.0
        buttom.layer.shadowOpacity = 0.2
        buttom.layer.borderColor = UIColor.customNavy.cgColor
        buttom.layer.borderWidth = 5.0
        
        buttom.setImage(UIImage(systemName: "headphones"), for: .normal)
        buttom.tintColor = .white
        buttom.contentMode = .scaleAspectFill
        buttom.contentVerticalAlignment = .fill
        buttom.contentHorizontalAlignment = .fill
        
        buttom.translatesAutoresizingMaskIntoConstraints = false
        
        return buttom
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music in Eyes"
        
        view.backgroundColor = .white
        [recordButton].forEach { view.addSubview($0) }
        configureConstraints()
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            recordButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            recordButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIScreen.main.bounds.height / 15)])
    }
}
