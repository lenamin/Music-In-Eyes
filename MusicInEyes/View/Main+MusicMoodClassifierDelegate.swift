//
//  Main+MusicMoodClassifierDelegate.swift
//  MusicInEyes
//
//  Created by Lena on 2022/09/01.
//

import UIKit

extension MainViewController: MusicMoodClassifierDelegate {
    
    func displayPredictionResult(identifier: String, confidence: Double) {
        
        let percentConfidence = String(format: "%.2f", confidence)
        print(identifier, percentConfidence)
        
        DispatchQueue.main.async {
            if identifier != "non-music" {
                self.musicMoodImageView.query = identifier
                didChangeValue(forKey: self.musicMoodImageView.query)
            } else {
                self.musicMoodImageView.image = nil
            }
            self.musicMoodImageView.reloadInputViews()
        }
        
        func didChangeValue(forKey key: String) {
            super.didChangeValue(forKey: "query")
            DispatchQueue.main.async {
                self.musicMoodImageView.fetchPhoto()
            }
            print("imageURL in didChangeValue : \(String(describing: musicMoodImageView.imageURL))")
            print("query in didChangeValue : \(musicMoodImageView.query)")
            musicMoodImageView.reloadInputViews()
        }
    }
}
