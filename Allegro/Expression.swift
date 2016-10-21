//
//  Expression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

/**
 The basic performable, recursively composable music object.
 */
public protocol Expression {
    /**
     The total duration of this expression.
     */
    var duration:Duration { get }
    
    /**
     Clones this expression.
     */
    func copy() -> Self
    
    /**
     Constructs a chord containing all the pitches at offset 0.
     */
    func firstChord() -> Chord?
    
    /**
     Recursively realizes the expression on some Performer instance.
     */
    func perform(on performer: Performer, completion: ((Void) -> Void)?)
    
    /**
     Divides an expression into two expressions at the specified offset.  Might result in chopping a note into two notes of smaller durations.
     */
    func cut(at offset:Duration) -> (Expression?, Expression?)
}

public extension Expression {
    public func slice(from:Duration, to:Duration) -> Expression? {
        return self.slice(to: to)?.slice(from: from)
    }
    
    public func slice(from offset:Duration) -> Expression? {
        let (_, tail) = self.cut(at: offset)
        return tail
    }
    
    public func slice(to offset:Duration) -> Expression? {
        let (head, _) = self.cut(at: offset)
        return head
    }
    
    /**
     Constructs a chord from the simultaneous pitches at a given offset.
     */
    public func chordAt(_ duration:Duration) -> Chord? {
        return self.slice(from: duration)?.firstChord()
    }
}

/**
 An atomic expression, not composed of smaller expressions.
 */
public protocol SimpleExpression: Expression {
    var duration: Duration { get set }
}

public extension SimpleExpression {
    public func cut(at offset: Duration) -> (Expression?, Expression?) {
        if self.duration < offset {
            return (self.copy(), nil)
        } else {
            var head = self.copy()
            var tail = self.copy()
            head.duration = offset
            tail.duration = self.duration - offset
            return (head, tail)
        }
    }
}


public protocol Sounded {
    var pitch:Pitch { get }
    var loudness: Loudness { get }
}
