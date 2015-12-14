//
//  Transposable.swift
//  Allegro
//
//  Created by Sam Williams on 12/6/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public protocol Transposable {
    func transposed(semitones semitones: Double) -> Self
}

public extension Transposable {
    func transposed(semitones semitones: Int) -> Self {
        return self.transposed(semitones: Double(semitones))
    }
    
    public func transposed(up interval: Interval) -> Self {
        return self.transposed(semitones: Double(interval.semitones))
    }
    
    public func transposed(down interval: Interval) -> Self {
        return self.transposed(semitones: Double(-interval.semitones))
    }
}