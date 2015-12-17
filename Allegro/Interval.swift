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

    static let Unison: Interval             = 0
    static let HalfStep: Interval           = 1
    static let WholeStep: Interval          = 2
    static let AugmentedSecond: Interval    = 3
    static let MinorThird: Interval         = 3
    static let MajorThird: Interval         = 4
    static let PerfectFourth: Interval      = 5
    static let AugmentedFourth: Interval    = 6
    static let PerfectFifth: Interval       = 7
    static let AugmentedFifth: Interval     = 8
    static let MajorSixth: Interval         = 9
    static let MinorSeventh: Interval       = 10
    static let MajorSeventh: Interval       = 11
    static let Octave: Interval             = 12
}

public enum IntervalQuality {
    case Perfect
    case Major
    case Minor
    case Augmented
    case Diminished
}
