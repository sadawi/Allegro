//
//  Chord.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

/**
A set of pitches sounded simultaneously.
If you want a chord with duration, use the ChordedNote class.
*/

public struct Chord: Hashable, Transposable {
    public var pitches:[Pitch]
    
    public init(_ pitches:[Pitch]) {
        self.pitches = pitches
    }
    
    /**
     Add a duration to a chord.
     */
    public func note(_ duration:Duration) -> ChordedNote {
        return ChordedNote(chord:self, duration:duration)
    }

    public func transposed(semitones: Double) -> Chord {
        return Chord(self.pitches.map{ $0.transposed(semitones: semitones) })
    }
    
    public var hashValue: Int {
        var result = self.pitches.count
        for pitch in self.pitches {
            result += pitch.hashValue * 31
        }
        return result
    }
}

public func ==(left:Chord, right:Chord) -> Bool {
    return left.pitches == right.pitches
}

public func /(chord:Chord, divisor:Int) -> ChordedNote {
    return chord.note(Duration(length: 1/Double(divisor)))
}

public func |(left:Pitch, right:Pitch) -> Chord {
    return Chord([left, right])
}

public func |(chord:Chord, pitch:Pitch) -> Chord {
    var pitches = chord.pitches
    pitches.append(pitch)
    return Chord(pitches)
}

public func |(left:Chord, right:Chord) -> Chord {
    return Chord(left.pitches + right.pitches)
}
