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
    private var timer:Timer!
    private var query: String?
    
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
    
    lazy var musicMoodImageView: UnsplashImageView = {
        let imageView = UnsplashImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music in Eyes"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .customBlack

        resultsObserver.moodDelegate = self
        
        view.backgroundColor = .white
        [bottomRectangle, contentLabelImage, musicMoodImageView].forEach { view.addSubview($0) }
        bottomRectangle.addSubview(recordButton)
        configureConstraints()
    }
    
    @objc func didToggleButton(_ sender: ToggleButton) {
        if sender.isOn {
            print("tapped on!")
            sender.setImage(UIImage(named: "stop-image"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(startMonitoring),
                                         userInfo: nil,
                                         repeats: true)
            timer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(startFetchImages),
                                         userInfo: nil,
                                         repeats: true)
            timer.fire()
        } else {
            print("tapped off")
            sender.setImage(UIImage(named: "listen-image"), for: .normal)
            audioEngine.stop()
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
            bottomRectangle.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15)
        ])
    }
    
    @objc func startMonitoring() {
        startMoodAudioEngine()
    }
}

extension MainViewController: MusicMoodClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        // TODO: 여기서 결과값 반환해서 이미지와 맞는 값 찾아주기
        DispatchQueue.main.async {
            print("mood Recognition: \(identifier)\nConfidence: \(confidence)")
            if identifier != "non-music" {
                let percentConfidence = String(format: "%.2f", confidence)
                self.contentLabel.text = "mood Recognition: \(identifier)\n Confidence: \(percentConfidence)"
            }
        }
    }
}
