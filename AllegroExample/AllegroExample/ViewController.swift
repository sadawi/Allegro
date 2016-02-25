//
//  ViewController.swift
//  AllegroExample
//
//  Created by Sam Williams on 12/16/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import UIKit
import Allegro
import PrimarySource

class ViewController: DataSourceViewController {
    let piano = SamplerInstrument(filename: "AJH_Piano", patchNumber: 0)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func play(expression:Expression) {
        self.piano.play(expression)
    }
    
    @IBAction func stop() {
        self.piano.stop()
    }
    
    override func configureDataSource(dataSource: DataSource) {
        dataSource <<< Section { section in
            
            section <<< TableViewItem<TableCell> { cell in
                cell.textLabel?.text = "Melody and chords"
                }.onTap { _ in
                    let melody = SequenceExpression(C.naturalMinorScale.pitchesStartingInOctave(4).map { $0/4 })
                    let chords = SequenceExpression([C.naturalMinorScale.triadFromDegree(.Tonic, octave: 3) / 1, C.naturalMinorScale.triadFromDegree(.Dominant, octave: 3) / 1])
                    self.play(melody|chords)
            }
            
            section <<< TableViewItem<TableCell> { cell in
                cell.textLabel?.text = "Sequence with rest"
                }.onTap { _ in
                    let music = A[4]/4 + G[4]/8 + B[4]/8 + R/8 + A[4]/2
                    self.play(music)
            }

//            section <<< TableViewItem<TableCell> { cell in
//                cell.textLabel?.text = "Constant generator"
//                }.onTap { _ in
//                    let generator = NoteGeneratorExpression(note: A[4]/4)
//                    self.play(generator)
//            }
            
            section <<< TableViewItem<TableCell> { cell in
                cell.textLabel?.text = "Generator"
                }.onTap { _ in
                    let melody = A[4]/4 + G[4]/4 + B[4]/4 + A[4]/4 + G[4]/4 + B[4]/4
                    let generator = OctaveSampler(context: melody)
                    self.play(melody | generator)
            }

            
            section <<< TableViewItem<TableCell> { cell in
                cell.textLabel?.text = "Dynamics"
                }.onTap { _ in
                    let music = (A[4]/4).loudness(𝆑) + (A[4]/4).loudness(𝆐𝆏) + (A[4]/4).loudness(𝆑𝆑𝆑)
                    self.play(music)
            }

            
        }
    }
    
}

