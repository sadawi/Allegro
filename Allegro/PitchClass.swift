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
public struct PitchClass: Equatable, Transposable, CustomStringConvertible {
    private var _semitones: Double = 0
    
    /**
     Number of semitones above the base (defined as C), bounded in [0,12]
     */
    public var semitones:Double {
        get { return _semitones }
        set { _semitones = fmod(newValue, Interval.octave.semitones) }
    }
    
    public init(semitones: Double) {
        self.semitones = semitones
    }
    
    public var sharp: PitchClass {
        return PitchClass(semitones: self.semitones+1)
    }
    
    public var flat: PitchClass {
        return PitchClass(semitones: self.semitones+11)
    }
    
    public var halfSharp: PitchClass {
        return PitchClass(semitones: self.semitones+0.5)
    }
    
    public var halfFlat: PitchClass {
        return PitchClass(semitones: self.semitones+11.5)
    }
    
    // TODO: keep track of spelling.  Interval transpositions should result in the correct new spelling.
    public func transposed(semitones semitones: Double) -> PitchClass {
        return PitchClass(semitones: self.semitones + semitones)
    }
    
    /**
     Shortcut to create a pitch with an octave.
     Example: A[4]
     
     Note: for correct parsing, postfix operators need a space after them before subscripting: A♯ [4] instead of A♯[4]
     */
    public subscript(octave:Int) -> Pitch {
        return self.pitch(octave)
    }
    
    public func pitch(octave:Int) -> Pitch {
        return Pitch(semitonesFromBase: Double(octave) * Interval.octave.semitones + Double(self.semitones))
    }
    
    public var description:String {
        switch self.semitones {
        case C.semitones: return "C"
        case C.sharp.semitones: return "C♯"
        case D.semitones: return "D"
        case D.sharp.semitones: return "D♯"
        case E.semitones: return "E"
        case F.semitones: return "F"
        case F.sharp.semitones: return "F♯"
        case G.semitones: return "G"
        case G.sharp.semitones: return "G♯"
        case A.semitones: return "A"
        case A.sharp.semitones: return "A♯"
        case B.semitones: return "B"
        default: return "\(self.semitones)"
        }
    }
    
}

public func ==(left:PitchClass, right:PitchClass) -> Bool {
    return left.semitones == right.semitones
}

/**

Public constants for the natural pitch classes.  Accidentals can be written as C.sharp, etc.

*/

public let C        = PitchClass(semitones: 0)
public let D        = PitchClass(semitones: 2)
public let E        = PitchClass(semitones: 4)
public let F        = PitchClass(semitones: 5)
public let G        = PitchClass(semitones: 7)
public let A        = PitchClass(semitones: 9)
public let B        = PitchClass(semitones: 11)