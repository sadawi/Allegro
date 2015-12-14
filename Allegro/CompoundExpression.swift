//
//  CompoundExpression.swift
//  Allegro
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public class CompoundExpression: Expression {
    var expressions:[Expression] = []

    public init() {
    }
    
    public init(expressions:[Expression]) {
        self.expressions = expressions
    }
    
    public var duration: Duration {
        // Subclasses should implement
        return Duration(length: 0)
    }

}