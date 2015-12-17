//
//  Rest.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct Rest: Expression, Equatable {
    public var duration:Duration

    public init(_ duration:Duration) {
        self.duration = duration
    }
    
    public func perform(on performer: Performer, completion: (Void -> Void)?) {
        performer.perform(duration: self.duration, completion: completion)
    }

    // TODO: seems repetitive with ChordedNote and Note
    public func cut(at offset: Duration) -> (Expression?, Expression?) {
        if self.duration < offset {
            return (self.copy(), nil)
        } else {
            var head = self.copy() as! Rest
            var tail = self.copy() as! Rest
            head.duration = offset
            tail.duration = self.duration - offset
            return (head, tail)
        }
    }

    public func copy() -> Expression {
        return Rest(self.duration)
    }
    
    public func firstChord() -> Chord? {
        return nil
    }
}

public func ==(left:Rest, right:Rest) -> Bool {
    return left.duration == right.duration
}

public let 𝄻 = Duration.Whole.rest
public let 𝄼 = Duration.Half.rest
public let 𝄽 = Duration.Quarter.rest
public let 𝄾 = Duration.Eighth.rest
public let 𝄿 = Duration.Sixteenth.rest
public let 𝅀 = Duration.ThirtySecond.rest
public let 𝅁 = Duration.SixtyFourth.rest
public let 𝅂 = Duration.OneHundredTwentyEighth.rest


/**
 A pseudo-pitch that can sometimes be used in place of a pitch to create a Rest with duration.
 Might want to make this an actual Pitch?
 */
public struct RestPitch { }
public let R = RestPitch()

/**
 This allows a sequence like A[4]/4 + R/4
 */
public func /(left:RestPitch, divisor: Int) -> Rest {
    return Rest(Duration(length: 1/Double(divisor)))
}