//
//  Scale.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class Scale {
    public class var intervals: [Interval] {
        return []
    }
    
    public var tonic:PitchClass
    
    public init(tonic:PitchClass) {
        self.tonic = tonic
    }
    
    public func pitches(octave octave:Int) {
    }
    
    public func pitch(degree degree:Int) {
        
    }
}

public class ChromaticScale: Scale {
    public override class var intervals: [Interval] {
        return [
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
            Interval.halfStep,
        ]
    }
}

public class DiatonicScale: Scale {
}

public class MajorScale: DiatonicScale {
    public override class var intervals: [Interval] {
        return [
            Interval.wholeStep,
            Interval.wholeStep,
            Interval.halfStep,
            Interval.wholeStep,
            Interval.wholeStep,
            Interval.wholeStep,
            Interval.halfStep,
        ]
    }
    
    public var relativeMinorScale: NaturalMinorScale {
        return NaturalMinorScale(tonic: self.tonic.transposed(down: Interval.minorThird))
    }
    
}

public class NaturalMinorScale: DiatonicScale {
    public override class var intervals: [Interval] {
        return [
            Interval.wholeStep,
            Interval.halfStep,
            Interval.wholeStep,
            Interval.wholeStep,
            Interval.halfStep,
            Interval.wholeStep,
            Interval.wholeStep,
        ]
    }
}