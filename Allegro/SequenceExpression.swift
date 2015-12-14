//
//  SequenceExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class SequenceExpression: CompoundExpression, ArrayLiteralConvertible {
    
    // "Synthesizing a variadic inherited initializer for subclass is unsupported"
    public required init(arrayLiteral expressions: Expression...) {
        super.init(expressions: expressions)
    }
    
    public override init(expressions: [Expression]) {
        super.init(expressions: expressions)
    }

    public override var duration: Duration {
        var result:Float = 0.0
        for expression in self.expressions {
            result += expression.duration.length
        }
        return Duration(length: result)
    }
    
    public func add(expression:Expression) {
        self.expressions.append(expression)
    }
}