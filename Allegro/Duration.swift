//
//  Duration.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct Duration: Equatable {
    /**
     Arbitrary units representing the length in time.
     */
    public var length:Double
    
    public var dotted: Duration {
        return self * 1.5
    }
    
    public var triplet: Duration {
        return self.tuplet(3)!
    }
    
    public func tuplet(number:Int) -> Duration? {
        if number > 1 {
            return self * Double(number-1) / Double(number)
        } else {
            return nil
        }
    }
    
    public static let Whole                     = Duration(length: 1)
    public static let Half                      = Whole / 2
    public static let Quarter                   = Half / 2
    public static let Eighth                    = Quarter / 2
    public static let Sixteenth                 = Eighth / 2
    public static let ThirtySecond              = Sixteenth / 2
    public static let SixtyFourth               = ThirtySecond / 2
    public static let OneHundredTwentyEighth    = SixtyFourth / 2
    
    public var rest: Rest {
        return Rest(duration: self)
    }
}

public func == (left:Duration, right:Duration) -> Bool {
    return left.length == right.length
}

public func / (duration:Duration, number:Double) -> Duration {
    return Duration(length: duration.length / number)
}

public func / (duration:Duration, number:Int) -> Duration {
    return Duration(length: duration.length / Double(number))
}

public func * (duration:Duration, number:Double) -> Duration {
    return Duration(length: duration.length * number)
}

public func * (number:Double, duration:Duration) -> Duration {
    return Duration(length: duration.length * number)
}

public func + (duration:Duration, number:Double) -> Duration {
    return Duration(length: duration.length + number)
}

public func + (number:Double, duration:Duration) -> Duration {
    return Duration(length: duration.length + number)
}

public func + (durationOne:Duration, durationTwo:Duration) -> Duration {
    return Duration(length: durationOne.length + durationTwo.length)
}

public let 𝅝 = Duration.Whole
public let 𝅗𝅥 = Duration.Half
public let 𝅘𝅥 = Duration.Quarter
public let 𝅘𝅥𝅮 = Duration.Eighth
public let 𝅘𝅥𝅯 = Duration.Sixteenth
public let 𝅘𝅥𝅰 = Duration.ThirtySecond
public let 𝅘𝅥𝅱 = Duration.SixtyFourth
public let 𝅘𝅥𝅲 = Duration.OneHundredTwentyEighth

public func *(duration:Duration, pitch:Pitch) -> Note {
    return pitch.note(duration)
}

public func *(pitch:Pitch, duration:Duration) -> Note {
    return pitch.note(duration)
}

public func *(duration:Duration, pitches:[Pitch]) -> SequenceExpression {
    let notes = pitches.map { $0.note(duration) as Expression }
    return SequenceExpression(notes)
}

public func *(pitches:[Pitch], duration:Duration) -> SequenceExpression {
    return duration * pitches
}