//
//  SequenceExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class SequenceExpression: CompoundExpression {
    public var expressions:[Expression] = []
    
    public init(expressions:[Expression]=[]) {
        self.expressions = expressions
    }
    
    public var duration: Duration {
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