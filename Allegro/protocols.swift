//
//  Expression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public protocol Temporal {
    var duration:Duration { get }
}

public protocol Sounded {
    var pitch:Pitch { get }
}