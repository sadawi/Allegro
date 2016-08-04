//
//  ChordedNote.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct ChordedNote: SimpleExpression {
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
        let notes:[Expression] = chord.pitches.map { Note(pitch: $0, duration: duration / chord.pitches.count, loudness: self.loudness) }
        return SequenceExpression(notes)
    }

    public func perform(on performer: Performer, completion: (Void -> Void)?) {
        for pitch in self.chord.pitches {
            performer.perform(pitch: pitch, loudness: self.loudness, duration: self.duration, completion: nil)
        }
        performer.perform(duration: self.duration, completion: completion)
    }
    
    public func firstChord() -> Chord? {
        return self.chord
    }
 
    public func copy() -> ChordedNote {
        return ChordedNote(chord: self.chord, duration: self.duration, loudness: self.loudness)
    }

}