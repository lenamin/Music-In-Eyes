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
    
    public var identifierLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var bottomRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var contentLabelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "InitialImage")
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
        musicMoodImageView.addSubview(identifierLable)
        bottomRectangle.addSubview(recordButton)
        configureConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: 1 - Asks user for microphone permission
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) != .authorized {
            AVCaptureDevice.requestAccess(for: AVMediaType.audio,
                                          completionHandler: { (granted: Bool) in
            })
        }
    }
    
    @objc func didToggleButton(_ sender: ToggleButton) {
        if sender.isOn {
            print("tapped on!")
            sender.setImage(sender.stopImage, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(startMonitoring),
                                         userInfo: nil,
                                         repeats: true)
            timer.fire()
        } else {
            timer.invalidate()
            stopMonitoring()
            sender.setImage(sender.playImage, for: .normal)
            musicMoodImageView.image = nil
            identifierLable.text = nil
            self.contentLabelImage.image = UIImage(named: "InitialImage")
            print("tapped off")
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            contentLabelImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabelImage.widthAnchor.constraint(equalToConstant:  UIScreen.main.bounds.width * 0.7),
            contentLabelImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentLabelImage.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -UIScreen.main.bounds.height * 0.2),
            
            musicMoodImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicMoodImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            musicMoodImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            musicMoodImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            musicMoodImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            musicMoodImageView.bottomAnchor.constraint(equalTo: bottomRectangle.topAnchor),
        
            identifierLable.centerXAnchor.constraint(equalTo: musicMoodImageView.centerXAnchor),
            identifierLable.centerYAnchor.constraint(equalTo: musicMoodImageView.centerYAnchor),
            
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
        if audioEngine.isRunning {
            stopMoodAudioEngine()
        }
    }
}

