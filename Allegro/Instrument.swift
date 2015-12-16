//
//  Instrument.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public enum InstrumentState {
    case Playing
    case Paused
    case Stopped
}

public protocol Performer {
    func stop()
    func play(expression: Expression)
    func perform(pitch pitch:Pitch?, loudness:Loudness?, duration:Duration, completion:(Void -> Void)?)
    func perform(duration duration:Duration, completion:(Void -> Void)?)
}

public class Instrument: Performer {
    public var state:InstrumentState = .Stopped
    public var tempo:Tempo = Tempo(100)

    public func stop() {
        self.state = .Stopped
    }
    
    public func play(expression: Expression) {
        // TODO: a stop that actually works here, when I redo the timing system.
        self.stop()
        self.state = .Playing
        expression.perform(on: self, completion: nil)
    }
    
    public func perform(duration duration:Duration, completion:(Void -> Void)?) {
        self.perform(pitch: nil, loudness: nil, duration: duration, completion: completion)
    }
    
    public func perform(pitch pitch:Pitch?, loudness:Loudness?, duration:Duration, completion:(Void -> Void)?) {
        guard self.state != .Stopped else { return }
        
        let interval = self.tempo.timeIntervalForDuration(duration)
        if let pitch = pitch, loudness = loudness {
            self.startPlayingPitch(pitch, loudness: loudness)
            
            // TODO: a more accurate, cancelable timer
            delay(interval) {
                self.stopPlayingPitch(pitch)
                if self.state == .Playing {
                    completion?()
                }
            }
        } else {
            delay(interval, completion)
        }
    }

    // TODO: maybe move this into the Sampler subclass.  the separate start/stop
    func startPlayingPitch(pitch:Pitch, loudness:Loudness) {
        
    }
    
    func stopPlayingPitch(pitch:Pitch) {
        
    }
}