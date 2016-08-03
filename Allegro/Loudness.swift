//
//  Loudness.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation


public struct Loudness {
    public var amount:Double = 1
    
    public static let Pianississimo     = Loudness(amount: 0.0625)
    public static let Pianissimo        = Loudness(amount: 0.125)
    public static let Piano             = Loudness(amount: 0.25)
    public static let MezzoPiano        = Loudness(amount: 0.5)
    public static let MezzoForte        = Loudness(amount: 0.75)
    public static let Forte             = Loudness(amount: 1)
    public static let Fortissimo        = Loudness(amount: 1.5)
    public static let Fortississimo     = Loudness(amount: 2)
}

public let 𝆏𝆏𝆏 = Loudness.Pianississimo
public let 𝆏𝆏 = Loudness.Pianissimo
public let 𝆏 = Loudness.Piano
public let 𝆐𝆏 = Loudness.MezzoPiano
public let 𝆐𝆑 = Loudness.MezzoForte
public let 𝆑 = Loudness.Forte
public let 𝆑𝆑 = Loudness.Fortissimo
public let 𝆑𝆑𝆑 = Loudness.Fortississimo