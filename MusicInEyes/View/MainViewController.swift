//
//  MainViewController.swift
//  MusicInEyes
//
//  Created by Lena on 2022/08/26.
//

import UIKit
import AVKit
import SoundAnalysis

class MainViewController: UIViewController {
    public var timer:Timer!
    @Published public var query: String?
    
    lazy var recordButton: ToggleButton = {
        
        let toggleButton = ToggleButton()
        toggleButton.stopImage = UIImage(named: "stop-image")
        toggleButton.playImage = UIImage(named: "listen-image")
        toggleButton.setTitleColor(.white, for: .normal)
        toggleButton.tintColor = .white
        
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        
        toggleButton.addTarget(self,
                               action: #selector(didToggleButton(_:)),
                               for: .touchUpInside)
        
        return toggleButton
    }()
    
    private var bottomRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var contentLabelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "content-label")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public var musicMoodImageView: UnsplashImageView = {
        let imageView = UnsplashImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music in Eyes"
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .customBlack

        resultsObserver.moodDelegate = self
        view.backgroundColor = .white
        [bottomRectangle, contentLabelImage, musicMoodImageView].forEach { view.addSubview($0) }
        bottomRectangle.addSubview(recordButton)
        configureConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func didToggleButton(_ sender: ToggleButton) {
        if sender.isOn {
            print("sender.isOn: \(sender.isOn)")
            print("tapped on!")
            sender.setImage(sender.stopImage, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(startMonitoring),
                                         userInfo: nil,
                                         repeats: true)
            timer.fire()
        } else {
            print("!sender.isOn: \(sender.isOn)")
            sender.setImage(sender.playImage, for: .normal)
            print("tapped off")
            stopMonitoring()
            musicMoodImageView.image = nil
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            contentLabelImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabelImage.widthAnchor.constraint(equalToConstant:  UIScreen.main.bounds.width * 0.5),
            contentLabelImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentLabelImage.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -UIScreen.main.bounds.height * 0.2),
            
            musicMoodImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicMoodImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            musicMoodImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            musicMoodImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            musicMoodImageView.bottomAnchor.constraint(equalTo: bottomRectangle.topAnchor),
        
            recordButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            recordButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIScreen.main.bounds.height / 22),
            
            bottomRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomRectangle.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            bottomRectangle.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.16)
        ])
    }
    
    @objc func startMonitoring() {
        startMoodAudioEngine()
    }
    
    func stopMonitoring() {
        audioEngine.pause()
    }
}

