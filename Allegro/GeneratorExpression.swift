//
//  GeneratorExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/16/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation


public class GeneratorExpression: Expression {

    public var duration:Duration {
        return Duration.Infinite
    }
    
    public func perform(on performer: Performer, completion: (Void -> Void)?) {
    }
    
    public func copy() -> Self {
        return self
    }
    
    public func firstChord() -> Chord? {
        return nil
    }
    
    public func cut(at offset: Duration) -> (Expression?, Expression?) {
        return (nil, nil)
    }
}

public class ContextGeneratorExpression: GeneratorExpression {
    public var context:Expression
    
    public init(context:Expression) {
        self.context = context
    }
    
    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
        self.context.perform(on: performer, completion: completion)
    }
}

//public class NoteGeneratorExpression: GeneratorExpression {
//    public var note:Note
//
//    public init(note:Note) {
//        self.note = note
//    }
//    
//    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
//        self.note.perform(on: performer) {
//            self.perform(on: performer, completion: nil)
//        }
//    }
//}

public class OctaveSampler: ContextGeneratorExpression {
    public var period:Duration = Duration.Half
    public var offset:Duration = Duration.Zero
    
    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
        if let chord = self.context.chordAt(self.offset) {
            let note = chord.transposed(down: Interval.Octave).note(Duration.Quarter)
            note.perform(on: performer, completion: nil)
        }
        self.offset = self.offset + self.period

        // Wait, then start again
        performer.perform(duration: self.period) {
            self.perform(on: performer, completion: nil)
        }
    }
}
