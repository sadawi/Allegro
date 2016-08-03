//
//  TimeSignature.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public struct TimeSignature {
    public var beatsPerBar:Int?
    public var beatDuration:Duration
    
    public static let CommonTime    = TimeSignature(beatsPerBar: 4, beatDuration: 𝅘𝅥)
    public static let CutTime       = TimeSignature(beatsPerBar: 2, beatDuration: 𝅗𝅥)
    public static let ThreeFour     = TimeSignature(beatsPerBar: 3, beatDuration: 𝅘𝅥)
}

public let 𝄴 = TimeSignature.CommonTime
public let 𝄵 = TimeSignature.CutTime