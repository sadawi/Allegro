//
//  delay.swift
//  Allegro
//
//  Created by Sam Williams on 12/15/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

public func delay(_ delay:TimeInterval, _ closure:((Void)->Void)?) {
    guard let closure = closure else { return }
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
