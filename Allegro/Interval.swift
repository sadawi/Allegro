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

    public static let Unison: Interval             = 0
    public static let HalfStep: Interval           = 1
    public static let WholeStep: Interval          = 2
    public static let AugmentedSecond: Interval    = 3
    public static let MinorThird: Interval         = 3
    public static let MajorThird: Interval         = 4
    public static let PerfectFourth: Interval      = 5
    public static let AugmentedFourth: Interval    = 6
    public static let PerfectFifth: Interval       = 7
    public static let AugmentedFifth: Interval     = 8
    public static let MajorSixth: Interval         = 9
    public static let MinorSeventh: Interval       = 10
    public static let MajorSeventh: Interval       = 11
    public static let Octave: Interval             = 12
}

public enum IntervalQuality {
    case Perfect
    case Major
    case Minor
    case Augmented
    case Diminished
}
