//
//  Interval.swift
//  Allegro
//
//  Created by Sam Williams on 12/5/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public enum Interval: Int {
    case Unison             = 0
    case HalfStep           = 1
    case WholeStep          = 2
    case MinorThird         = 3
    case MajorThird         = 4
    case PerfectFourth      = 5
    case AugmentedFourth    = 6
    case PerfectFifth       = 7
    case AugmentedFifth     = 8
    case MajorSixth         = 9
    case MinorSeventh       = 10
    case MajorSeventh       = 11
    case Octave             = 12
    
    static let MinorSecond = Interval.HalfStep
}
