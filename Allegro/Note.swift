//
//  Note.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//


public struct Note: Sounded, Expression, Transposable, Equatable {
    public var pitch:Pitch
    public var duration:Duration
    
    // MARK: - Transformation shortcuts
    
    var dotted:Note { return Note(pitch: self.pitch, duration: self.duration.dotted) }

    public func transposed(semitones semitones:Double) -> Note {
        return Note(pitch: self.pitch.transposed(semitones: semitones), duration: self.duration)
    }
    
    // MARK: - To other data types
    
    public func tremolo(duration:Duration = Duration.ThirtySecond) -> SequenceExpression {
        let count = Int(self.duration.length / duration.length)
        let result = SequenceExpression()
        for _ in 0..<count {
            result.expressions.append(Note(pitch: self.pitch, duration: duration))
        }
        return result
    }
    
}

public func ==(left:Note, right:Note) -> Bool {
    return left.pitch == right.pitch && left.duration == right.duration
}