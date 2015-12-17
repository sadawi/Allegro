//
//  ParallelExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

/**
 An Expression containing subexpressions that are realized simultaneously.
 Its duration is considered to be equal to that of its longest subexpression.
 */
public class ParallelExpression: Expression, ArrayLiteralConvertible {
    var expressions:[Expression] = []

    public required init(arrayLiteral expressions: Expression...) {
        self.expressions = expressions
    }
    
    public required init(_ expressions:[Expression]) {
        self.expressions = expressions
    }
    
    public var duration: Duration {
        var result:Double = 0.0
        for expression in self.expressions {
            result = max(result, expression.duration.length)
        }
        return Duration(length: result)
    }
    
    public func perform(on performer: Performer, completion: (Void -> Void)?) {
        for expression in self.expressions {
            expression.perform(on: performer, completion: nil)
        }
        performer.perform(duration: self.duration, completion: completion)
    }

    public func copy() -> Self {
        return self.dynamicType.init(self.expressions)
    }

    public func cut(at offset: Duration) -> (Expression?, Expression?) {
        var heads:[Expression] = []
        var tails:[Expression] = []
        
        for expression in self.expressions {
            let (head, tail) = expression.cut(at: offset)
            if let head = head {
                heads.append(head)
            }
            if let tail = tail {
                tails.append(tail)
            }
        }
        
        return (ParallelExpression(heads), ParallelExpression(tails))
    }
    
    public func firstChord() -> Chord? {
        let chords:[Chord] = self.expressions.map { $0.firstChord() }.flatMap { $0 }
        var result = Chord([])
        for chord in chords {
            result = result | chord
        }
        return result
    }
}

public func |(left:Expression, right:Expression) -> ParallelExpression {
    return ParallelExpression([left, right])
}

public func |(left:[Expression], right:Expression) -> ParallelExpression {
    return ParallelExpression([SequenceExpression(left), right])
}

public func |(left:Expression, right:[Expression]) -> ParallelExpression {
    return ParallelExpression([left, SequenceExpression(right)])
}