//
//  MainViewController.swift
//  MusicInEyes
//
//  Created by Lena on 2022/08/26.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var recordButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .customNavy
        button.layer.cornerRadius = (UIScreen.main.bounds.width * 0.2) / 2
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 7.0
        button.layer.shadowOpacity = 0.2
        button.layer.borderColor = UIColor.customNavy.cgColor
        button.layer.borderWidth = 5.0
        
        button.setImage(UIImage(systemName: "headphones"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var bottomRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "탭하여 ME하기"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.textColor = .customBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    */
    
    private var musicMoodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music in Eyes"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .customBlack

        view.backgroundColor = .white
        [bottomRectangle, musicMoodImageView].forEach { view.addSubview($0) }
        bottomRectangle.addSubview(recordButton)
        configureConstraints()
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            /*
            contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -UIScreen.main.bounds.height * 0.2),
            */
            
            musicMoodImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicMoodImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            musicMoodImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            musicMoodImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.4),
            
            recordButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            recordButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIScreen.main.bounds.height / 15),
            
            bottomRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomRectangle.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            bottomRectangle.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.18)
        ])
    }
}
