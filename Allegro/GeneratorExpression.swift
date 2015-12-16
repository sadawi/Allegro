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
}

public class ContextGeneratorExpression: GeneratorExpression {
    public var context:Expression
    
    public init(context:Expression) {
        self.context = context
    }
    
    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
    }
}

public class NoteGeneratorExpression: GeneratorExpression {
    public var note:Note

    public init(note:Note) {
        self.note = note
    }
    
    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
        self.note.perform(on: performer) {
            self.perform(on: performer, completion: nil)
        }
    }
}

public class OctaveGeneratorExpression: GeneratorExpression {
    public override init() {
        super.init()
    }
    
    public override func perform(on performer: Performer, completion: (Void -> Void)?) {
        
    }
}
