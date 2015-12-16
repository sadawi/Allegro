//
//  delay.swift
//  Allegro
//
//  Created by Sam Williams on 12/15/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation

func delay(delay:NSTimeInterval, _ closure:(Void->Void)?) {
    guard let closure = closure else { return }
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}