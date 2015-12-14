//
//  Interval.swift
//  Allegro
//
//  Created by Sam Williams on 12/5/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct Interval: FloatLiteralConvertible, IntegerLiteralConvertible {
    public var semitones: Double
    public var quality: IntervalQuality?
    
    public init(semitones: Double) {
        self.semitones = semitones
    }
    
    public init(floatLiteral value: FloatLiteralType) {
        self.semitones = value
    }

    public init(integerLiteral value: IntegerLiteralType) {
        self.semitones = Double(value)
    }

    static let unison: Interval             = 0
    static let halfStep: Interval           = 1
    static let wholeStep: Interval          = 2
    static let augmentedSecond: Interval    = 3
    static let minorThird: Interval         = 3
    static let majorThird: Interval         = 4
    static let perfectFourth: Interval      = 5
    static let augmentedFourth: Interval    = 6
    static let perfectFifth: Interval       = 7
    static let augmentedFifth: Interval     = 8
    static let majorSixth: Interval         = 9
    static let minorSeventh: Interval       = 10
    static let majorSeventh: Interval       = 11
    static let octave: Interval             = 12
}


//public enum ScaleDegree: Int {
//    case Unison     = 1
//    case Second     = 2
//    case Third      = 3
//    case Fourth     = 4
//    case Fifth      = 5
//    case Sixth      = 6
//    case Seventh    = 7
//    case Octave     = 8
//}
//
public enum IntervalQuality {
    case Perfect
    case Major
    case Minor
    case Augmented
    case Diminished
}
