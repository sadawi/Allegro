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
    
    public init(_ tonic:PitchClass) {
        self.tonic = tonic
    }
    
    public func pitchClasses() -> [PitchClass] {
        return self.pitches(startingInOctave: 0).map { $0.pitchClass }
    }
    
    public func pitches(startingInOctave octave:Int) -> [Pitch] {
        var pitch = self.tonic[octave]
        var pitches:[Pitch] = []
        for interval in self.dynamicType.intervals {
            pitches.append(pitch)
            pitch = pitch.transposed(up: interval)
        }
        return pitches
    }
    
    public func pitches(startingWith pitch:Pitch) -> [Pitch] {
        if let index = self.indexOf(pitch.pitchClass) {
            var pitch = pitch
            var pitches:[Pitch] = []
            let intervals = self.dynamicType.intervals
            for i in 0..<intervals.count {
                pitches.append(pitch)
                let interval = intervals[(index + i) % intervals.count]
                pitch = pitch.transposed(up: interval)
            }
            return pitches
        } else {
            return []
        }
    }
    
    // MARK: - Degrees
    
    public func pitchClassForDegree(degree:Int) -> PitchClass {
        return self.tonic.transposed(up: self.intervalFromTonicToDegree(degree))
    }
    
    public subscript(degree:Int) -> PitchClass {
        return self.pitchClassForDegree(degree)
    }
    
    public func intervalFromTonicToDegree(degree: Int) -> Interval {
        var semitones:Double = 0.0
        let intervals = self.dynamicType.intervals
        let scaleLength = intervals.count
        let wrappedDegree = degree % scaleLength // in [0, 6] for major scale, for example
        
        let octaves = floor((Double(degree))/Double(scaleLength));
        semitones += Interval.Octave.semitones * octaves;
        
        for i in 0..<wrappedDegree {
            let intervalNumber = self.dynamicType.intervals[i]
            semitones += intervalNumber.semitones
        }
        return Interval(semitones: semitones);
    }
    
    public func indexOf(pitchClass:PitchClass) -> Int? {
        return self.pitchClasses().indexOf(pitchClass)
    }
    
    public func contains(pitchClass: PitchClass) -> Bool {
        return self.indexOf(pitchClass) != nil
    }
}

public class ChromaticScale: Scale {
    public override class var intervals: [Interval] {
        return [
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
            .HalfStep,
        ]
    }
}

public enum DiatonicScaleDegree: Int {
    case Tonic          = 1
    case Supertonic     = 2
    case Mediant        = 3
    case Subdominant    = 4
    case Dominant       = 5
    case Submediant     = 6
    case LeadingTone    = 7
    
    public static let All:[DiatonicScaleDegree] = [.Tonic, .Supertonic, .Mediant, .Subdominant, .Dominant, .Submediant, .LeadingTone]
}


public class DiatonicScale: Scale {
    
    public var supertonic:  PitchClass { return self[DiatonicScaleDegree.Supertonic] }
    public var mediant:     PitchClass { return self[DiatonicScaleDegree.Mediant] }
    public var subdominant: PitchClass { return self[DiatonicScaleDegree.Subdominant] }
    public var dominant:    PitchClass { return self[DiatonicScaleDegree.Dominant] }
    public var submediant:  PitchClass { return self[DiatonicScaleDegree.Submediant] }
    public var leadingTone: PitchClass { return self[DiatonicScaleDegree.LeadingTone] }
    
    public func degree(of pitch: Pitch) -> DiatonicScaleDegree? {
        if let index = self.indexOf(pitch.pitchClass) {
            return DiatonicScaleDegree(rawValue: index+1)
        } else {
            return nil
        }
    }
    
    public func triad(from degree: DiatonicScaleDegree, octave:Int) -> Chord {
        let pitch = self.pitchClass(of: degree)[octave]
        return self.triad(from: pitch)!
    }
    
    public func triad(from pitch: Pitch) -> Chord? {
        let pitches = self.pitches(startingWith: pitch)
        if pitches.count >= 5 {
            return Chord([pitches[0], pitches[2], pitches[4]])
        } else {
            return nil
        }
    }
    
    public func pitchClass(of degree:DiatonicScaleDegree) -> PitchClass {
        return self.pitchClassForDegree(degree.rawValue - 1)
    }
    
    public subscript(degree:DiatonicScaleDegree) -> PitchClass {
        return self.pitchClass(of: degree)
    }
    
    public func triads(startingInOctave octave: Int) -> [Chord] {
        return self.pitches(startingInOctave: octave).map { self.triad(from: $0)! }
    }
    
}

public class MajorScale: DiatonicScale {
    public override class var intervals: [Interval] {
        return [
            .WholeStep,
            .WholeStep,
            .HalfStep,
            .WholeStep,
            .WholeStep,
            .WholeStep,
            .HalfStep,
        ]
    }
    
    public var relativeMinorScale: NaturalMinorScale {
        return NaturalMinorScale(self.tonic.transposed(down: Interval.MinorThird))
    }
    
}

public class NaturalMinorScale: DiatonicScale {
    public var relativeMajorScale: MajorScale {
        return MajorScale(self.tonic.transposed(up: Interval.MinorThird))
    }
    
    public override class var intervals: [Interval] {
        return [
            .WholeStep,
            .HalfStep,
            .WholeStep,
            .WholeStep,
            .HalfStep,
            .WholeStep,
            .WholeStep,
        ]
    }
}

public class HarmonicMinorScale: DiatonicScale {
    public override class var intervals: [Interval] {
        return [
            .WholeStep,
            .HalfStep,
            .WholeStep,
            .WholeStep,
            .HalfStep,
            .AugmentedSecond,
            .HalfStep,
        ]
    }
}

extension PitchClass {
    public var majorScale:MajorScale {
        return MajorScale(self)
    }
    
    public var naturalMinorScale:NaturalMinorScale {
        return NaturalMinorScale(self)
    }
}