//
//  MIDI.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

struct MIDI {
    static let C0MIDINumber:UInt8 = 12 // Or is it?
    static let MinimumMIDINumber:UInt8 = 0
    static let MaximumMIDINumber:UInt8 = 127
}

extension Pitch {
    public var MIDINumber:UInt8 {
        return UInt8(C[0].semitones(to: self)) + MIDI.C0MIDINumber
    }
}

extension Loudness {
    public var MIDIVelocity:UInt8 {
        return UInt8(self.amount * 100)
    }
}