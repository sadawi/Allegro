//
//  Duration.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct Duration: Equatable {
    public var length:Float
    
    public var dotted: Duration {
        var result = self
        result.length *= 1.5
        return result
    }
    
    public static let Whole                     = Duration(length: 1)
    public static let Half                      = Whole / 2
    public static let Quarter                   = Half / 2
    public static let Eighth                    = Quarter / 2
    public static let Sixteenth                 = Eighth / 2
    public static let ThirtySecond              = Sixteenth / 2
    public static let SixtyFourth               = ThirtySecond / 2
    public static let OneHundredTwentyEighth    = SixtyFourth / 2
}

public func == (left:Duration, right:Duration) -> Bool {
    return left.length == right.length
}

public func / (duration:Duration, number:Float) -> Duration {
    return Duration(length: duration.length / number)
}

public func * (duration:Duration, number:Float) -> Duration {
    return Duration(length: duration.length * number)
}

public func * (number:Float, duration:Duration) -> Duration {
    return Duration(length: duration.length * number)
}

public func + (duration:Duration, number:Float) -> Duration {
    return Duration(length: duration.length + number)
}

public func + (number:Float, duration:Duration) -> Duration {
    return Duration(length: duration.length + number)
}

public let 𝅝 = Duration.Whole
public let 𝅗𝅥 = Duration.Half
public let 𝅘𝅥 = Duration.Quarter
public let 𝅘𝅥𝅮 = Duration.Eighth
public let 𝅘𝅥𝅯 = Duration.Sixteenth
public let 𝅘𝅥𝅰 = Duration.ThirtySecond
public let 𝅘𝅥𝅱 = Duration.ThirtySecond