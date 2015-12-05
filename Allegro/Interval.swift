//
//  Interval.swift
//  Allegro
//
//  Created by Sam Williams on 12/5/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

//public enum Interval: Int {
//    case Unison             = 0
//    case HalfStep           = 1
//    case WholeStep          = 2
//    case MinorThird         = 3
//    case MajorThird         = 4
//    case PerfectFourth      = 5
//    case AugmentedFourth    = 6
//    case PerfectFifth       = 7
//    case AugmentedFifth     = 8
//    case MajorSixth         = 9
//    case MinorSeventh       = 10
//    case MajorSeventh       = 11
//    case Octave             = 12
//}
//

public enum ScaleDegree: Int {
    case Unison     = 1
    case Second     = 2
    case Third      = 3
    case Fourth     = 4
    case Fifth      = 5
    case Sixth      = 6
    case Seventh    = 7
    case Octave     = 8
}

public enum IntervalQuality {
    case Perfect
    case Major
    case Minor
    case Augmented
    case Diminished
}

public struct Interval {
    public var quality: IntervalQuality
    public var number: ScaleDegree
    
//    https://en.wikipedia.org/wiki/Lipps%E2%80%93Meyer_law
//    public func lippsMeyer() -> Bool {
//
//    }
    
    public static let HalfStep = Interval(quality: .Minor, number: .Second)
    public static let WholeStep = Interval(quality: .Major, number: .Second)
    public static let Octave = Interval(quality: .Perfect, number: .Octave)
    
    public var semitones: Int {
        switch (quality, number) {

        case (.Perfect, .Unison):       return 0
        case (.Diminished, .Second):    return 0
            
        case (.Augmented, .Unison):     return 1
        case (.Minor, .Second):         return 1

        case (.Major, .Second):         return 2
        case (.Diminished, .Third):     return 2
        
        case (.Minor, .Third):          return 3
        case (.Augmented, .Second):     return 3
        
        case (.Major, .Third):          return 4
        case (.Diminished, .Fourth):    return 4
        
        case (.Perfect, .Fourth):       return 5
        case (.Augmented, .Third):      return 5
        
        case (.Augmented, .Fourth):     return 6
        case (.Diminished, .Fifth):     return 6
        
        case (.Perfect, .Fifth):        return 7
        case (.Diminished, .Sixth):     return 7
        
        case (.Augmented, .Fifth):      return 8
        case (.Minor, .Sixth):          return 8
        
        case (.Major, .Sixth):          return 9
        case (.Diminished, .Seventh):   return 9

        case (.Minor, .Seventh):        return 10
        case (.Augmented, .Sixth):      return 10

        case (.Major, .Seventh):        return 11
        case (.Diminished, .Octave):    return 11

        case (.Perfect, .Octave):       return 12
        case (.Augmented, .Seventh):    return 12
            
        default:                return 0
        }
    }
}