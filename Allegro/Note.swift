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
    public var loudness:Loudness = 𝆐𝆑

    public var clone: Note {
        return Note(pitch: self.pitch, duration: self.duration, loudness: self.loudness)
    }
    
    init(pitch:Pitch, duration:Duration) {
        self.pitch = pitch
        self.duration = duration
    }
    
    init(pitch:Pitch, duration:Duration, loudness:Loudness) {
        self.pitch = pitch
        self.duration = duration
        self.loudness = loudness
    }
    
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
    
    public func perform(on performer: Performer, completion: (Void -> Void)?) {
        performer.perform(pitch: self.pitch, loudness: self.loudness, duration: self.duration, completion: completion)
    }
    
    public func loudness(loudness: Loudness) -> Note {
        var note = self.clone
        note.loudness = loudness
        return note
    }
    
//    // TODO: ensure to > from
//    public func slice(from from: Duration?, to: Duration?) -> Expression? {
//        let from = from ?? Duration.Zero
//        let to = to ?? self.duration
//        return Note(pitch: self.pitch, duration: to - from)
//    }
    
    public func cut(at offset: Duration) -> (Expression?, Expression?) {
        if self.duration < offset {
            return (self.copy(), nil)
        } else {
            var head = self.copy() as! Note
            var tail = self.copy() as! Note
            head.duration = offset
            tail.duration = self.duration - offset
            return (head, tail)
        }
    }
    
    public func firstChord() -> Chord? {
        return Chord([self.pitch])
    }
    
    public func copy() -> Expression {
        return Note(pitch: self.pitch, duration: self.duration, loudness: self.loudness)
    }
}

public func ==(left:Note, right:Note) -> Bool {
    return left.pitch == right.pitch && left.duration == right.duration
}