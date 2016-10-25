//
//  Performer.swift
//  Allegro
//
//  Created by Sam Williams on 10/24/16.
//  Copyright © 2016 Sam Williams. All rights reserved.
//

import Foundation

public protocol Performer {
    func stop()
    func play(_ expression: Expression)
    func perform(pitch:Pitch?, loudness:Loudness?, duration:Duration, completion:((Void) -> Void)?)
    func perform(duration:Duration, completion:((Void) -> Void)?)
}

