//
//  ViewController.swift
//  AllegroExample
//
//  Created by Sam Williams on 12/16/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import UIKit
import Allegro

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let piano = SamplerInstrument(filename: "AJH_Piano", patchNumber: 0) {
            let music = SequenceExpression(expressions: C.majorScale.pitchesStartingInOctave(4).map { $0/8 })
            music.perform(on: piano, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

