//
//  ChordedNote.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct ChordedNote: Expression {
    public var chord:Chord
    public var duration:Duration
    public var loudness:Loudness
    
    public init(chord:Chord, duration:Duration, loudness:Loudness = 𝆐𝆑) {
        self.chord = chord
        self.duration = duration
        self.loudness = loudness
    }
    
    // MARK: - To other data types
    
    public var arpeggio: SequenceExpression {
        let notes:[Expression] = chord.pitches.map { Note(pitch: $0, duration: duration / chord.pitches.count) }
        return SequenceExpression(notes)
    }

    public func perform(on performer: Performer, completion: (Void -> Void)?) {
        for pitch in self.chord.pitches {
            performer.perform(pitch: pitch, loudness: self.loudness, duration: self.duration, completion: nil)
        }
        performer.perform(duration: self.duration, completion: completion)
    }

    
//    // TODO: ensure to > from
//    public func slice(from from: Duration?, to: Duration?) -> Expression? {
//        let from = from ?? Duration.Zero
//        let to = to ?? self.duration
//        return ChordedNote(chord: self.chord, duration: to - from)
//    }
    
    public func cut(at offset: Duration) -> (Expression?, Expression?) {
        if self.duration < offset {
            return (self.copy(), nil)
        } else {
            var head = self.copy() as! ChordedNote
            var tail = self.copy() as! ChordedNote
            head.duration = offset
            tail.duration = self.duration - offset
            return (head, tail)
        }
    }
    
    public func firstChord() -> Chord? {
        return self.chord
    }
 
    public func copy() -> Expression {
        return ChordedNote(chord: self.chord, duration: self.duration, loudness: self.loudness)
    }

}