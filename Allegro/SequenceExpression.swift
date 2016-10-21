//
//  SequenceExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

/**
 An Expression containing subexpressions that are realized in timewise sequence, one after the other.
 */
open class SequenceExpression: Expression, ExpressibleByArrayLiteral, CustomStringConvertible {
    open var expressions:[Expression] = []
    
    open var head:Expression? {
        if self.expressions.count > 0 {
            return self.expressions[0]
        } else {
            return nil
        }
    }
    
    open var tail:SequenceExpression? {
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
    
    public required init(_ expressions: [Expression]) {
        self.expressions = expressions
    }
    
    public init(expressions: [Expression]) {
        self.expressions = expressions
    }
    
    open var duration: Duration {
        var result:Double = 0.0
        for expression in self.expressions {
            result += expression.duration.length
        }
        return Duration(length: result)
    }
    
    open func copy() -> Self {
        return type(of: self).init(self.expressions)
    }
    
    open func add(_ expression:Expression) {
        self.expressions.append(expression)
    }
    
    open func perform(on performer: Performer, completion: ((Void) -> Void)?) {
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
    
    open func firstChord() -> Chord? {
        return self.head?.firstChord()
    }
    
    open func cut(at offset: Duration) -> (Expression?, Expression?) {
        if offset.length == 0 {
            return (nil, self)
        }
        var head:SequenceExpression? = nil
        var tail:SequenceExpression? = nil
        
        if self.duration < offset {
            head = self.copy()
            tail = nil
        } else {
            head = SequenceExpression()
            tail = SequenceExpression()
            
            var remaining = offset
            for expression in self.expressions {
                let expression = expression.copy()
                if expression.duration <= remaining {
                    head?.add(expression)
                    remaining = remaining - expression.duration
                } else if remaining.length > 0 {
                    let (newHead, newTail) = expression.cut(at: remaining)
                    if let newHead = newHead {
                        head?.add(newHead)
                        remaining = remaining - newHead.duration
                    }
                    if let newTail = newTail {
                        tail?.add(newTail)
                    }
                } else {
                    tail?.add(expression)
                }
            }
        }
        
        //        head.offset = Duration.Zero  // TODO
        //        tail.offset = offset
        
        return (head, tail)
    }
    
    open var description:String {
        return self.expressions.map { "(\($0))" }.joined(separator: " ")
    }
    
}

public func +(left:Expression, right:Expression) -> SequenceExpression {
    if let leftSequence = left as? SequenceExpression {
        var expressions = leftSequence.expressions
        expressions.append(right)
        return SequenceExpression(expressions)
    } else {
        return SequenceExpression([left, right])
    }
}

public func *(count:Int, expression:Expression) -> SequenceExpression {
    let result = SequenceExpression()
    for _ in 0..<count {
        result.add(expression)
    }
    return result
}

public func *(expression:Expression, count:Int) -> SequenceExpression {
    return count * expression
}
