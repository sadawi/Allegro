//
//  Pitch.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

/**
Pitches represent absolute frequencies of notes; different octaves are different pitches.

These are equal tempered pitches, defined as a number of semitones from an arbitrary base (say, C0).
*/

public struct Pitch {
    public var semitonesFromBase:Float = 0
    
    // MARK: -

    public var octave:Int {
        return Int(floor(self.semitonesFromBase / Float(Interval.Octave.rawValue)))
    }

    public var pitchClass:PitchClass {
        return PitchClass(semitones: Int(self.semitonesFromBase))
    }
    
    // MARK: - Transpositions
    
    public func transposed(up interval: Interval) -> Pitch {
        return self.transposed(by: Float(interval.rawValue))
    }

    public func transposed(down interval: Interval) -> Pitch {
        return self.transposed(by: Float(-interval.rawValue))
    }
    
    public func transposed(by semitones: Float) -> Pitch {
        return Pitch(semitonesFromBase: self.semitonesFromBase + semitones)
    }
    
    // MARK: - Building other data types
    
    /**
    Add a duration to a pitch, and you have a note.
    */
    public func note(duration:Duration) -> Note {
        return Note(pitch:self, duration:duration)
    }

}

/**
Now you can write A[4]/16
*/
public func /(pitch:Pitch, divisor:Int) -> Note {
    return pitch.note(Duration(length: 1/Float(divisor)))
}
