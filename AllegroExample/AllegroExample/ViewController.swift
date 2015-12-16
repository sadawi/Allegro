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
//            let melody = SequenceExpression(C.naturalMinorScale.pitchesStartingInOctave(4).map { $0/4 })
//            let chords = SequenceExpression([C.naturalMinorScale.triadFromDegree(.Tonic, octave: 3) / 1])
//            
//            (melody|chords).perform(on: piano, completion: nil)
            
//            let music = A[4]/4 | C[4]/4

//            let music = (A[4]|C[4])/4
            let music = [ A[4]/4, B[4]/4 ] | A[2]/2

            music.perform(on: piano, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

