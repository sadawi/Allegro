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

public struct Pitch: Transposable, Hashable, CustomStringConvertible {
    public var semitonesFromBase:Double = 0
    
    // MARK: -
    
    public var octave:Int {
        return Int(floor(self.semitonesFromBase / Double(Interval.Octave.semitones)))
    }
    
    public var pitchClass:PitchClass {
        return PitchClass(semitones: self.semitonesFromBase)
    }
    
    public func transposed(semitones semitones: Double) -> Pitch {
        return Pitch(semitonesFromBase: self.semitonesFromBase + semitones)
    }
    
    // MARK: - Building other data types
    
    /**
    Add a duration to a pitch, and you have a note.
    */
    public func note(duration:Duration) -> Note {
        return Note(pitch:self, duration:duration)
    }
    
    public func semitones(to pitch:Pitch) -> Double {
        return pitch.semitonesFromBase - self.semitonesFromBase
    }
    
    public var description:String {
        return "\(self.pitchClass)\(self.octave)"
    }
    
    public var hashValue: Int {
        return self.semitonesFromBase.hashValue
    }
}

/**
 Now you can write A.flat[4]/16, etc.
 */
public func /(pitch:Pitch, divisor:Int) -> Note {
    return pitch.note(Duration(length: 1/Double(divisor)))
}


public func ==(left:Pitch, right:Pitch) -> Bool {
    return left.semitonesFromBase == right.semitonesFromBase
}