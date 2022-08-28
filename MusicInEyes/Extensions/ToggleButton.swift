//
//  ToggleButton.swift
//  MusicInEyes
//
//  Created by Lena on 2022/08/28.
//

import UIKit

class ToggleButton: UIButton {
    var isOn: Bool = false {
        didSet {
            updateDisplay()
        }
    }
    
    var stopImage: UIImage! = nil {
        didSet {
            updateDisplay()
        }
    }
    
    var playImage: UIImage! = nil {
        didSet {
            updateDisplay()
        }
    }
    
    func updateDisplay() {
        if isOn {
            if let stopImage = stopImage {
                setImage(stopImage, for: .normal)
            }
        } else {
            if let playImage = playImage {
                setImage(playImage, for: .normal)
            }
        }
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        isOn = !isOn
    }
}
