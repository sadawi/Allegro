//
//  Scale.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class Scale {
    public class func intervals() -> [Interval] {
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

public class DiatonicScale: Scale {
}

public class MajorScale: Scale {
    
    public override class func intervals() -> [Interval] {
        return [
            Interval.WholeStep,
            Interval.WholeStep,
            Interval.HalfStep,
            Interval.WholeStep,
            Interval.WholeStep,
            Interval.WholeStep,
            Interval.HalfStep,
        ]
    }
    
}
