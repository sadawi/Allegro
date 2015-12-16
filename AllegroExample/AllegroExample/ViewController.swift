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
        let piano = SamplerInstrument(filename: "AJH_Piano", patchNumber: 0)
        piano?.playNote(A[4]/4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

