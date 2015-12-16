//
//  Instrument.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public protocol Performer {
    func perform(pitch pitch:Pitch?, loudness:Loudness?, duration:Duration, completion:(Void -> Void)?)
    func perform(duration duration:Duration, completion:(Void -> Void)?)
}

public class Instrument: Performer {
    public var tempo:Tempo = Tempo(100)

//    public func perform(expression:Expression, completion: (Void -> Void)) {
//        expression.each { subexpression, next in
//            self.play(subexpression, next: next)
//        }
//    }
//    
    
    public func perform(duration duration:Duration, completion:(Void -> Void)?) {
        self.perform(pitch: nil, loudness: nil, duration: duration, completion: completion)
    }
    
    public func perform(pitch pitch:Pitch?, loudness:Loudness?, duration:Duration, completion:(Void -> Void)?) {
        
        let interval = self.tempo.timeIntervalForDuration(duration)
        if let pitch = pitch, loudness = loudness {
            self.startPlayingPitch(pitch, loudness: loudness)
            delay(interval) {
                self.stopPlayingPitch(pitch)
                completion?()
            }
        } else {
            delay(interval, completion)
        }
    }

    func startPlayingPitch(pitch:Pitch, loudness:Loudness) {
        
    }
    
    func stopPlayingPitch(pitch:Pitch) {
        
    }
}