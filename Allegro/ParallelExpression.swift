//
//  ParallelExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class ParallelExpression: Expression, ArrayLiteralConvertible {
    var expressions:[Expression] = []

    public required init(arrayLiteral expressions: Expression...) {
        self.expressions = expressions
    }
    
    public init(_ expressions:[Expression]) {
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

}

public func |(left:Expression, right:Expression) -> ParallelExpression {
    return ParallelExpression([left, right])
}