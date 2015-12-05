//
//  Note.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//


public struct Note: Sounded, Temporal {
    public var pitch:Pitch
    public var duration:Duration
    
    public func transposed(up interval:Interval) -> Note {
        return Note(pitch: self.pitch.transposed(up: interval), duration: self.duration)
    }
    
    public func tremolo(duration:Duration = Duration.ThirtySecond) -> SequenceExpression {
        let count = Int(self.duration.length / duration.length)
        let result = SequenceExpression()
        for _ in 0..<count {
            result.expressions.append(Note(pitch: self.pitch, duration: duration))
        }
        return result
    }
}