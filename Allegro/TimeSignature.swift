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
    
    public static let commonTime = TimeSignature(beatsPerBar: 4, beatDuration: 𝅘𝅥)
    public static let cutTime = TimeSignature(beatsPerBar: 2, beatDuration: 𝅗𝅥)
    public static let threeFour = TimeSignature(beatsPerBar: 3, beatDuration: 𝅘𝅥)
}
