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
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        
        guard let result = result as? SNClassificationResult else { return }
        
        var temp = [(label: String, confidence: Double)]()
        var results = [(label: String, confidence: Double)]()
        
        let sorted = result.classifications.sorted { first, second -> Bool in
            return first.confidence > second.confidence
        }
        for classification in sorted {
            let confidence = classification.confidence * 100
            if confidence > 60 {
                temp.append((label: classification.identifier, confidence: confidence))
                results = temp
                moodDelegate?.displayPredictionResult(identifier: results.first?.label ?? String(),
                                                      confidence: results.first?.confidence ?? Double())
            }
        }
    }
    
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        print("request completed successfully!")
    }
}
