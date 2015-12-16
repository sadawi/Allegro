//
//  GeneratorExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/16/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation


//public class GeneratorExpression: Expression {
//
//    public var duration:Duration {
//        return Duration.Infinite
//    }
//    
//    public func perform(on performer: Performer, completion: (Void -> Void)?) {
//    }
//}
//
//public class ContextGeneratorExpression: GeneratorExpression {
//    public var context:Expression
//    
//    public init(context:Expression) {
//        self.context = context
//    }
//    
//    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
//    }
//}
//
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
//
//public class Sampler: ContextGeneratorExpression {
//    public var period:Duration = Duration.Whole
//    public var offset:Duration = Duration.Zero
//    
//    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
//        let chord = self.context.chordAt(self.offset)
//        let note = chord.note(Duration.Quarter)
//        
//        note.perform(on: performer, completion: nil)
//        
//        self.offset = self.offset + self.period
//
//        // Wait, then start again
//        performer.perform(duration: self.period) {
//            self.perform(on: performer, completion: nil)
//        }
//    }
//}
