//
//  Tempo.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct Tempo {
    public var referenceDuration:Duration
    public var perMinute:Int
    
    public func timeIntervalForDuration(duration:Duration) -> NSTimeInterval {
        return duration.length / referenceDuration.length / Double(self.perMinute) * 60
    }
    
}