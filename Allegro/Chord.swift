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

public struct Chord {
    public var pitches:[Pitch]
    
    /**
     Add a duration to a chord.
     */
    public func note(duration:Duration) -> ChordedNote {
        return ChordedNote(chord:self, duration:duration)
    }

}

public func /(chord:Chord, divisor:Int) -> ChordedNote {
    return chord.note(Duration(length: 1/Double(divisor)))
}
