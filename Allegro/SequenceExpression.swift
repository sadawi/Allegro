//
//  SequenceExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class SequenceExpression: Expression, ArrayLiteralConvertible {
    var expressions:[Expression] = []
    
    var head:Expression? {
        if self.expressions.count > 0 {
            return self.expressions[0]
        } else {
            return nil
        }
    }

    var tail:SequenceExpression? {
        if self.expressions.count > 1 {
            let a = self.expressions
            return SequenceExpression(Array(a[1..<a.count]))
        } else {
            return nil
        }
    }

    public required init(arrayLiteral expressions: Expression...) {
        self.expressions = expressions
    }
    
    public init(_ expressions: [Expression]) {
        self.expressions = expressions
    }

    public var duration: Duration {
        var result:Double = 0.0
        for expression in self.expressions {
            result += expression.duration.length
        }
        return Duration(length: result)
    }
    
    public func add(expression:Expression) {
        self.expressions.append(expression)
    }
    
    public func perform(on performer: Performer, completion: (Void -> Void)?) {
        if let head = self.head {
            head.perform(on: performer) {
                if let tail = self.tail {
                    tail.perform(on: performer, completion: completion)
                } else {
                    completion?()
                }
            }
        } else {
            completion?()
        }
    }
}
