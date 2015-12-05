//
//  Pitch.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
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

public enum PitchClass: Int {
    case C          = 0
    case Csharp     = 1
    case D          = 2
    case Dsharp     = 3
    case E          = 4
    case F          = 5
    case Fsharp     = 6
    case G          = 7
    case Gsharp     = 8
    case A          = 9
    case Asharp     = 10
    case B          = 11
    
    static let Dflat = PitchClass.Csharp
    static let Eflat = PitchClass.Dsharp
    static let Gflat = PitchClass.Fsharp
    static let Aflat = PitchClass.Gsharp
    static let Bflat = PitchClass.Asharp
    
    public var sharp: PitchClass {
        return PitchClass(rawValue: (self.rawValue+1) % Interval.Octave.rawValue)!
    }

    public var flat: PitchClass {
        return PitchClass(rawValue: (self.rawValue+11) % 12)!
    }
}

public struct Pitch {
    static var tuning = Tuning.A440
    
    private var semitonesFromBase:Float = 0
    
    public func transposed(up interval: Interval) -> Pitch {
        return self.transposed(by: Float(interval.rawValue))
    }

    public func transposed(down interval: Interval) -> Pitch {
        return self.transposed(by: Float(-interval.rawValue))
    }
    
    public func transposed(by semitones: Float) -> Pitch {
        return Pitch(semitonesFromBase: self.semitonesFromBase + semitones)
    }
}