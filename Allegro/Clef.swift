//
//  Clef.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public enum ClefType {
    case g
    case c
    case f
    case percussion
}

public enum Clef {
    case treble
    case bass
    case alto
}

public let 𝄞 = ClefType.g
public let 𝄢 = ClefType.f
public let 𝄡 = ClefType.c
public let 𝄥 = ClefType.percussion
