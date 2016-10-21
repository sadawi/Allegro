//
//  Scale.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

open class Scale {
    open class var intervals: [Interval] {
        return []
    }
    
    open var tonic:PitchClass
    
    public init(_ tonic:PitchClass) {
        self.tonic = tonic
    }
    
    open func pitchClasses() -> [PitchClass] {
        return self.pitches(startingInOctave: 0).map { $0.pitchClass }
    }
    
    open func pitches(startingInOctave octave:Int) -> [Pitch] {
        var pitch = self.tonic[octave]
        var pitches:[Pitch] = []
        for interval in type(of: self).intervals {
            pitches.append(pitch)
            pitch = pitch.transposed(up: interval)
        }
        return pitches
    }
    
    open func pitches(startingWith pitch:Pitch) -> [Pitch] {
        if let index = self.indexOf(pitch.pitchClass) {
            var pitch = pitch
            var pitches:[Pitch] = []
            let intervals = type(of: self).intervals
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
    
    open func pitchClassForDegree(_ degree:Int) -> PitchClass {
        return self.tonic.transposed(up: self.intervalFromTonicToDegree(degree))
    }
    
    open subscript(degree:Int) -> PitchClass {
        return self.pitchClassForDegree(degree)
    }
    
    open func intervalFromTonicToDegree(_ degree: Int) -> Interval {
        var semitones:Double = 0.0
        let intervals = type(of: self).intervals
        let scaleLength = intervals.count
        let wrappedDegree = degree % scaleLength // in [0, 6] for major scale, for example
        
        let octaves = floor((Double(degree))/Double(scaleLength));
        semitones += Interval.Octave.semitones * octaves;
        
        for i in 0..<wrappedDegree {
            let intervalNumber = type(of: self).intervals[i]
            semitones += intervalNumber.semitones
        }
        return Interval(semitones: semitones);
    }
    
    open func indexOf(_ pitchClass:PitchClass) -> Int? {
        return self.pitchClasses().index(of: pitchClass)
    }
    
    open func contains(_ pitchClass: PitchClass) -> Bool {
        return self.indexOf(pitchClass) != nil
    }
}

open class ChromaticScale: Scale {
    open override class var intervals: [Interval] {
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
    case tonic          = 1
    case supertonic     = 2
    case mediant        = 3
    case subdominant    = 4
    case dominant       = 5
    case submediant     = 6
    case leadingTone    = 7
    
    public static let All:[DiatonicScaleDegree] = [.tonic, .supertonic, .mediant, .subdominant, .dominant, .submediant, .leadingTone]
}


open class DiatonicScale: Scale {
    
    open var supertonic:  PitchClass { return self[DiatonicScaleDegree.supertonic] }
    open var mediant:     PitchClass { return self[DiatonicScaleDegree.mediant] }
    open var subdominant: PitchClass { return self[DiatonicScaleDegree.subdominant] }
    open var dominant:    PitchClass { return self[DiatonicScaleDegree.dominant] }
    open var submediant:  PitchClass { return self[DiatonicScaleDegree.submediant] }
    open var leadingTone: PitchClass { return self[DiatonicScaleDegree.leadingTone] }
    
    open func degree(of pitch: Pitch) -> DiatonicScaleDegree? {
        if let index = self.indexOf(pitch.pitchClass) {
            return DiatonicScaleDegree(rawValue: index+1)
        } else {
            return nil
        }
    }
    
    open func triad(from degree: DiatonicScaleDegree, octave:Int) -> Chord {
        let pitch = self.pitchClass(of: degree)[octave]
        return self.triad(from: pitch)!
    }
    
    open func triad(from pitch: Pitch) -> Chord? {
        let pitches = self.pitches(startingWith: pitch)
        if pitches.count >= 5 {
            return Chord([pitches[0], pitches[2], pitches[4]])
        } else {
            return nil
        }
    }
    
    open func pitchClass(of degree:DiatonicScaleDegree) -> PitchClass {
        return self.pitchClassForDegree(degree.rawValue - 1)
    }
    
    open subscript(degree:DiatonicScaleDegree) -> PitchClass {
        return self.pitchClass(of: degree)
    }
    
    open func triads(startingInOctave octave: Int) -> [Chord] {
        return self.pitches(startingInOctave: octave).map { self.triad(from: $0)! }
    }
    
}

open class MajorScale: DiatonicScale {
    open override class var intervals: [Interval] {
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
    
    open var relativeMinorScale: NaturalMinorScale {
        return NaturalMinorScale(self.tonic.transposed(down: Interval.MinorThird))
    }
    
}

open class NaturalMinorScale: DiatonicScale {
    open var relativeMajorScale: MajorScale {
        return MajorScale(self.tonic.transposed(up: Interval.MinorThird))
    }
    
    open override class var intervals: [Interval] {
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

open class HarmonicMinorScale: DiatonicScale {
    open override class var intervals: [Interval] {
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
