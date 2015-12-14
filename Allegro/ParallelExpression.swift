//
//  ParallelExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class ParallelExpression: CompoundExpression, ArrayLiteralConvertible {
    
    // "Synthesizing a variadic inherited initializer for subclass is unsupported"
    public required init(arrayLiteral expressions: Expression...) {
        super.init(expressions: expressions)
    }
    
    public override var duration: Duration {
        var result:Double = 0.0
        for expression in self.expressions {
            result = max(result, expression.duration.length)
        }
        return Duration(length: result)
    }
}