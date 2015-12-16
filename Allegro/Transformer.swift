//
//  Transformers.swift
//  Allegro
//
//  Created by Sam Williams on 12/16/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

//// Default is just a passthrough.
//public class UnaryTransformer: Expression {
//    public var input: Expression
//    
//    public init(input: Expression) {
//        self.input = input
//    }
//    
//    public var duration:Duration {
//        return self.input.duration
//    }
//    
//    public func perform(on performer: Performer, completion: (Void -> Void)?) {
//        self.input.perform(on: performer, completion: completion)
//    }
//}
//
//public class TranspositionTransformer: UnaryTransformer {
//    public var interval: Interval
//    
//    public init(input: Expression, interval: Interval) {
//        self.interval = interval
//        super.init(input: input)
//    }
//}