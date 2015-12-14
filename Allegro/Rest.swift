//
//  Rest.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct Rest: Expression, Equatable {
    public var duration:Duration
}

public func ==(left:Rest, right:Rest) -> Bool {
    return left.duration == right.duration
}


public let 𝄻 = Duration.Whole.rest
public let 𝄼 = Duration.Half.rest
public let 𝄽 = Duration.Quarter.rest
public let 𝄾 = Duration.Eighth.rest
public let 𝄿 = Duration.Sixteenth.rest
