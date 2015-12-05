//
//  PitchClass.swift
//  Allegro
//
//  Created by Sam Williams on 12/5/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

postfix operator ♯ { }
postfix operator ♭ { }

public postfix func ♯(pitchClass:PitchClass) -> PitchClass {
    return pitchClass.sharp
}

public postfix func ♭(pitchClass:PitchClass) -> PitchClass {
    return pitchClass.flat
}


/**

The chroma of a pitch, regardless of octave.  C4 and C0 both have a pitchClass of C.



*/
public struct PitchClass: Equatable {
    private var _semitones: Int = 0
    
    /**
    Number of semitones above the base (defined as C), bounded in [0,12]
    */
    public var semitones:Int {
        get { return _semitones }
        set { _semitones = newValue % Interval.Octave.rawValue }
    }

    public init(semitones: Int) {
        self.semitones = semitones
    }
    
    public var sharp: PitchClass {
        return PitchClass(semitones: self.semitones+1)
    }
    
    public var flat: PitchClass {
        return PitchClass(semitones: self.semitones+11)
    }
    
    /**
    Shortcut to create a pitch with an octave.
    Example: A[4]
    */
    public subscript(octave:Int) -> Pitch {
        return self.pitch(octave)
    }

    public func pitch(octave:Int) -> Pitch {
        return Pitch(semitonesFromBase: Float(octave * Interval.Octave.rawValue + self.semitones))
    }
    
}

public func ==(left:PitchClass, right:PitchClass) -> Bool {
    return left.semitones == right.semitones
}

/**

Public constants for the natural pitch classes.  Accidentals can be written as C.sharp, etc.

I'm not totally sure making these global is a good idea, but it sure does make it more concise to write.
C.sharp[4].q, and so on

*/

public let C        = PitchClass(semitones: 0)
public let D        = PitchClass(semitones: 2)
public let E        = PitchClass(semitones: 4)
public let F        = PitchClass(semitones: 5)
public let G        = PitchClass(semitones: 7)
public let A        = PitchClass(semitones: 9)
public let B        = PitchClass(semitones: 11)