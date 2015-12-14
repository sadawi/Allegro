//
//  Clef.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public enum ClefType {
    case G
    case C
    case F
    case Percussion
}

public enum Clef {
    case Treble
    case Bass
    case Alto
}

public let 𝄞 = ClefType.G
public let 𝄢 = ClefType.F
public let 𝄡 = ClefType.C
public let 𝄥 = ClefType.Percussion
