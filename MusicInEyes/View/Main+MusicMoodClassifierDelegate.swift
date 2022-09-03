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
        
//        DispatchQueue.main.async {
//            if identifier != "non-music" {
//                 self.query = identifier
//                // print("displayPredictionResult 에 있는 query야 : \(self.query ?? String())")
//
//                // self.musicMoodImageView.query = self.query ?? String()
//
//                self.timer = Timer.scheduledTimer(withTimeInterval: 3,
//                                             repeats: true,
//                                             block: {_ in
//
//                    if let query = self.query {
//                        self.musicMoodImageView.query = query
//                    }
//                    self.musicMoodImageView.fetchPhoto()
//                    self.musicMoodImageView.reloadInputViews()
//                    print("url: \(self.musicMoodImageView.imageURL)")
//                    print("successfully fetched!: \(self.musicMoodImageView.query)")
//                })
//                self.timer.fire()
////                self.musicMoodImageView.fetchPhoto()
////                print("url: \(self.musicMoodImageView.imageURL)")
////                print("successfully fetched!: \(self.musicMoodImageView.query)")
//            } else {
//                print("I'm non-music")
//            }
//        }
        
        DispatchQueue.main.async {
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 3,
                                              repeats: true,
                                              block: {_ in
                
                if identifier != "non-music" {
                    self.musicMoodImageView.query = identifier
                    self.musicMoodImageView.fetchPhoto()
                    print("url: \(self.musicMoodImageView.imageURL)")
                    print("successfully fetched!: \(self.musicMoodImageView.query)")
                    self.musicMoodImageView.reloadInputViews()
                    
                    
                }
                else {
                    print("I'm non-music")
                }
            })
            self.timer.fire()
        }
    }
}
