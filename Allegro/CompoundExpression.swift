//
//  CompoundExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public protocol CompoundExpression: Temporal {
    var expressions:[Temporal] { get }
}