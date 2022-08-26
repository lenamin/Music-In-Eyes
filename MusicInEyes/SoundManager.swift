//
//  SoundManager.swift
//  MusicInEyes
//
//  Created by Lena on 2022/08/26.
//

import AVKit
import SoundAnalysis

let audioEngine = AVAudioEngine()

var soundClassifier = try! MusicMoodClassification()

var inputFormat: AVAudioFormat!
var analyzer: SNAudioStreamAnalyzer!
var resultsObserver = ResultsObserver()
let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")

protocol MusicMoodClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double)
}

public func startAudioEngine() {
    //create stream analyzer request with the Sound Classifier
    
    inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
    analyzer = SNAudioStreamAnalyzer(format: inputFormat)
    
    do {
        let request = try SNClassifySoundRequest(mlModel: soundClassifier.model)
        
        try analyzer.add(request, withObserver: resultsObserver)
        
    } catch {
        print("Unable to prepare request: \(error.localizedDescription)")
        return
    }
    
    audioEngine.inputNode.installTap(onBus: 0, bufferSize: 8000, format: inputFormat) { buffer, time in
        analysisQueue.async {
            analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
        }
    }
    
    do {
        try audioEngine.start()
    } catch( _) {
        print("error in starting the Audio Engine")
    }
}

class ResultsObserver: NSObject, SNResultsObserving {
    var delegate: MusicMoodClassifierDelegate?
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        
        let confidence = classification.confidence * 100.0
        
        if confidence > 60 {
            delegate?.displayPredictionResult(identifier: classification.identifier,
                                              confidence: confidence)
        }
    }
}



