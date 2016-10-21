//
//  Instrument.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public enum InstrumentState {
    case playing
    case paused
    case stopped
}

public protocol Performer {
    func stop()
    func play(_ expression: Expression)
    func perform(pitch:Pitch?, loudness:Loudness?, duration:Duration, completion:((Void) -> Void)?)
    func perform(duration:Duration, completion:((Void) -> Void)?)
}

open class Instrument: Performer {
    open var state:InstrumentState = .stopped
    open var tempo:Tempo = Tempo(100)

    open func stop() {
        self.state = .stopped
    }
    
    open func play(_ expression: Expression) {
        // TODO: a stop that actually works here, when I redo the timing system.
        self.stop()
        self.state = .playing
        expression.perform(on: self, completion: nil)
    }
    
    open func perform(duration:Duration, completion:((Void) -> Void)?) {
        self.perform(pitch: nil, loudness: nil, duration: duration, completion: completion)
    }
    
    open func perform(pitch:Pitch?, loudness:Loudness?, duration:Duration, completion:((Void) -> Void)?) {
        guard self.state != .stopped else { return }
        
        let interval = self.tempo.timeInterval(for: duration)
        if let pitch = pitch, let loudness = loudness {
            self.startPlayingPitch(pitch, loudness: loudness)
            
            // TODO: a more accurate, cancelable timer
            delay(interval) {
                self.stopPlayingPitch(pitch)
                if self.state == .playing {
                    completion?()
                }
            }
        } else {
            delay(interval, completion)
        }
    }

    // TODO: maybe move this into the Sampler subclass.  the separate start/stop
    func startPlayingPitch(_ pitch:Pitch, loudness:Loudness) {
        
    }
    
    func stopPlayingPitch(_ pitch:Pitch) {
        
    }
}
