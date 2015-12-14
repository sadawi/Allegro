//
//  SamplerInstrument.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation
import AVFoundation

public class SamplerInstrument: Instrument {
    public var filename:String
    public var patchNumber:UInt8
    public var bank:UInt8 = UInt8(kAUSampler_DefaultMelodicBankMSB)
    
    private let sampler = AVAudioUnitSampler()
    private let engine = AVAudioEngine()
    
    public init(filename:String, patchNumber:UInt8) {
        self.filename = filename
        self.patchNumber = patchNumber
    }
    
    public func playNoteWithMIDINumber(number:Int, duration:NSTimeInterval) {
        
    }
    
    public override func startPlayingPitch(pitch: Pitch) {
        
    }
    
    public override func stopPlayingPitch(pitch: Pitch) {
        
    }
    
    public func playNote(note:Note, then:(Void -> Void)) {
        self.playNoteWithMIDINumber(note.pitch.MIDINumber, duration: self.timeIntervalForDuration(note.duration))
    }
    
    private func setup() throws {
        self.engine.attachNode(self.sampler)
        self.engine.connect(self.sampler, to: self.engine.outputNode, format: nil)
        
        if let soundbankURL = NSBundle.mainBundle().URLForResource(self.filename, withExtension: "sf2") {
            try self.sampler.loadSoundBankInstrumentAtURL(soundbankURL, program: self.patchNumber, bankMSB: self.bank, bankLSB: 0)
        }
    }
}