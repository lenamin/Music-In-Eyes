//
//  ResultObserver.swift
//  MusicInEyes
//
//  Created by Lena on 2022/08/26.
//

import Foundation
import SoundAnalysis

class ResultsObserver: NSObject, SNResultsObserving {
    var moodDelegate: MusicMoodClassifierDelegate?
    var genreDelegate: MusicGenreClassifierDelegate?
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
                
        let confidence = classification.confidence * 100.0
        
        if confidence > 60 {
            moodDelegate?.displayPredictionResult(identifier: classification.identifier,
                                              confidence: confidence)
            genreDelegate?.displayPredictionResultGenre(identifier: classification.identifier,
                                              confidence: confidence)
        }
    }
    
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The the analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        print("request completed successfully!")
    }
}
