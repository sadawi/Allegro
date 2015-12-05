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
    
    // MARK: - To other data types
    
    public var arpeggio: SequenceExpression {
        let notes:[Expression] = chord.pitches.map { Note(pitch: $0, duration: duration / chord.pitches.count) }
        return SequenceExpression(expressions:notes)
    }

}