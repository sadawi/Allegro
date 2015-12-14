//
//  MIDI.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

struct MIDI {
    static let C0MIDINumber = 12 // Or is it?
}

extension Pitch {
    public var MIDINumber:Int {
        return Int(C[0].semitonesTo(self)) + MIDI.C0MIDINumber
    }
}