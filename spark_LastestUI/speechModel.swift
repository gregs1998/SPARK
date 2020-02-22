//
//  speechModel.swift
//  spark_LastestUI
//
//  Created by Greg Schloemer on 2/11/20.
//  Copyright © 2020 Greg Schloemer. All rights reserved.
//

import Foundation
import AVFoundation

public class speechModel{
    func speak(textToSay: String){
    let utterance = AVSpeechUtterance(string: textToSay)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5

    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
    }
    
}
