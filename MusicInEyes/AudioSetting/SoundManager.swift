//
//  SoundManager.swift
//  MusicInEyes
//
//  Created by Lena on 2022/08/26.
//

import AVKit
import SoundAnalysis

var soundMoodClassifier = try! MusicMoodClassification()

let audioEngine = AVAudioEngine()
let mixer = AVAudioPlayerNode()
var inputFormat: AVAudioFormat!
var analyzer: SNAudioStreamAnalyzer!

var resultsObserver = ResultsObserver()
let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")

protocol MusicMoodClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double)
}

public func startMoodAudioEngine() {

    inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
    analyzer = SNAudioStreamAnalyzer(format: inputFormat)
    
    audioEngine.inputNode.reset()
    audioEngine.inputNode.removeTap(onBus: 0)
    analyzer.removeAllRequests()
    
    do {
        let request = try SNClassifySoundRequest(mlModel: soundMoodClassifier.model)
        try analyzer.add(request, withObserver: resultsObserver)
        print("added")
    } catch {
        print(String(describing: error))
        return
    }
    
    do {
        try audioEngine.start()
        print("started")
    } catch {
        print("error in starting the Audio Engine")
    }

    audioEngine.inputNode.installTap(onBus: 0, bufferSize: 400, format: inputFormat) { buffer, time in
        analysisQueue.async {
            analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
        }
    }
}

public func stopMoodAudioEngine() {
    
    audioEngine.inputNode.removeTap(onBus: 0)
    audioEngine.reset()
    audioEngine.stop()
    analyzer.removeAllRequests()
}
