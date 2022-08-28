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
    
    private var mic = MicrophoneMonitor(numberOfSamples: 1)
    private var timer:Timer!
    
    lazy var recordButton: ToggleButton = {
        
        let toggleButton = ToggleButton()
        toggleButton.stopImage = UIImage(systemName: "stop.fill")
        toggleButton.playImage = UIImage(systemName: "headphones")
        toggleButton.setTitleColor(.white, for: .normal)
        toggleButton.tintColor = .white
        toggleButton.backgroundColor = .customNavy
        
        toggleButton.layer.cornerRadius = (UIScreen.main.bounds.width * 0.2) / 2
        toggleButton.layer.masksToBounds = false
        toggleButton.layer.shadowRadius = 7.0
        toggleButton.layer.shadowOpacity = 0.2
        toggleButton.layer.borderColor = UIColor.customNavy.cgColor
        toggleButton.layer.borderWidth = 5.0
        
//        toggleButton.contentMode = .scaleAspectFill
//        toggleButton.contentVerticalAlignment = .fill
//        toggleButton.contentHorizontalAlignment = .fill
        
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
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "탭하여 ME하기"
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.textColor = .customBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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

        resultsObserver.moodDelegate = self
        
        view.backgroundColor = .white
        [bottomRectangle, contentLabel, musicMoodImageView].forEach { view.addSubview($0) }
        bottomRectangle.addSubview(recordButton)
        configureConstraints()
    }
    
    @objc func didToggleButton(_ sender: ToggleButton) {
        if sender.isOn {
            sender.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(startMonitoring),
                                         userInfo: nil,
                                         repeats: true)
            timer.fire()
        } else {
            sender.setImage(UIImage(systemName: "headphones"), for: .normal)
            audioEngine.stop()
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -UIScreen.main.bounds.height * 0.2),
            
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
    
    @objc func startMonitoring() {
      print("sound level:", normalizeSoundLevel(level: mic.soundSamples.first!))
        let soundLevel = normalizeSoundLevel(level: mic.soundSamples.first!)
        if soundLevel > 60 {
            startMoodAudioEngine()
        } else {
            audioEngine.stop()
        }
    }

    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
    }
}


extension MainViewController: MusicMoodClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        // 여기서 결과값 반환해서 이미지와 맞는 값 찾아주기
        DispatchQueue.main.async {
            if confidence > 80 {
                let percentConfidence = String(format: "%.2f", confidence)
                self.contentLabel.text = "mood Recognition: \(identifier)\n Confidence: \(percentConfidence)"
                print("mood Recognition: \(identifier)\nConfidence: \(percentConfidence)")
            }
        }
    }
}
