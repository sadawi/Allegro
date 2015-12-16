//
//  Expression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public protocol Expression {
    var duration:Duration { get }
    
    func copy() -> Expression
    func firstChord() -> Chord?
    func perform(on performer: Performer, completion: (Void -> Void)?)
    func cut(at offset:Duration) -> (Expression?, Expression?)
}

public extension Expression {
    public func slice(from offset:Duration) -> Expression? {
        let (_, tail) = self.cut(at: offset)
        return tail
    }

    public func slice(to offset:Duration) -> Expression? {
        let (head, _) = self.cut(at: offset)
        return head
    }
    
    public func slice(from from:Duration, to:Duration) -> Expression? {
        return self.slice(to: to)?.slice(from: from)
    }
    
    public func chordAt(duration:Duration) -> Chord? {
        return self.slice(from: duration)?.firstChord()
    }
}


public protocol Sounded {
    var pitch:Pitch { get }
    var loudness: Loudness { get }
}