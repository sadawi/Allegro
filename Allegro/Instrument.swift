//
//  Instrument.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class Instrument {
    public var tempo:Tempo = Tempo(100)

    public func playNote(note:Note, then:(Void -> Void)?=nil) {
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