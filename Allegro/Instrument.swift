//
//  Instrument.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public protocol Performer {
    func perform(pitch pitch:Pitch?, duration:Duration?, completion:(Void -> Void)?)
    func perform(pitch pitch:Pitch?, completion:(Void -> Void)?)
    func perform(duration duration:Duration?, completion:(Void -> Void)?)
}

public class Instrument: Performer {
    public var tempo:Tempo = Tempo(100)

//    public func perform(expression:Expression, completion: (Void -> Void)) {
//        expression.each { subexpression, next in
//            self.play(subexpression, next: next)
//        }
//    }
//    
    public func perform(pitch pitch:Pitch?, completion:(Void -> Void)?) {
        self.perform(pitch: pitch, duration: nil, completion: completion)
    }
    
    public func perform(duration duration:Duration?, completion:(Void -> Void)?) {
        self.perform(pitch: nil, duration: duration, completion: completion)
    }
    
    public func perform(pitch pitch:Pitch?, duration:Duration?, completion:(Void -> Void)?) {
        
    }

    public func performNote(note:Note, completion:(Void -> Void)?=nil) {
        let interval = self.tempo.timeIntervalForDuration(note.duration)
        self.startPlayingPitch(note.pitch, loudness: note.loudness)
        delay(interval) {
            self.stopPlayingPitch(note.pitch)
        }
    }
    
    func startPlayingPitch(pitch:Pitch, loudness:Loudness) {
        
    }
    
    func stopPlayingPitch(pitch:Pitch) {
        
    }
}