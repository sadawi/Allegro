//
//  SequenceExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class SequenceExpression: CompoundExpression {
    public var expressions:[Temporal] = []
    
    public var duration: Duration {
        var result:Float = 0.0
        for expression in self.expressions {
            result += expression.duration.length
        }
        return Duration(length: result)
    }
    
    public func add(expression:Temporal) {
        self.expressions.append(expression)
    }
}