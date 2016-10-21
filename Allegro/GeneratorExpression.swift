//
//  GeneratorExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/16/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation


open class GeneratorExpression: Expression {

    open var duration:Duration {
        return Duration.Infinite
    }
    
    open func perform(on performer: Performer, completion: ((Void) -> Void)?) {
    }
    
    open func copy() -> Self {
        return self
    }
    
    open func firstChord() -> Chord? {
        return nil
    }
    
    open func cut(at offset: Duration) -> (Expression?, Expression?) {
        return (nil, nil)
    }
}

open class ContextGeneratorExpression: GeneratorExpression {
    open var context:Expression
    
    public init(context:Expression) {
        self.context = context
    }
    
    open override func perform(on performer: Performer, completion: ((Void) -> Void)?) {
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

open class OctaveSampler: ContextGeneratorExpression {
    open var period:Duration = Duration.Half
    open var offset:Duration = Duration.Zero
    
    open override func perform(on performer: Performer, completion: ((Void) -> Void)?) {
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
