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
    
    public init?(filename:String, patchNumber:UInt8) {
        self.filename = filename
        self.patchNumber = patchNumber
        
        super.init()
        
        do {
            try self.setup()
        } catch {
            return nil
        }
    }

    // MARK: - Overrides
    
    override func startPlayingPitch(pitch:Pitch, loudness:Loudness) {
        self.sampler.startNote(pitch.MIDINumber, withVelocity: loudness.MIDIVelocity, onChannel: 0)
    }
    
    override func stopPlayingPitch(pitch:Pitch) {
        self.sampler.stopNote(pitch.MIDINumber, onChannel: 0)
    }
    
    // MARK: - MIDI
    
    private func setup() throws {
        self.engine.attachNode(self.sampler)
        self.engine.connect(self.sampler, to: self.engine.outputNode, format: nil)
        
        if let soundbankURL = NSBundle.mainBundle().URLForResource(self.filename, withExtension: "sf2") {
            try self.engine.start()
            try self.sampler.loadSoundBankInstrumentAtURL(soundbankURL, program: self.patchNumber, bankMSB: self.bank, bankLSB: 0)
        }
    }
    
    
    public override func stop() {
        super.stop()
        for i in MIDI.MinimumMIDINumber..<MIDI.MaximumMIDINumber {
            self.sampler.stopNote(i, onChannel: 0)
        }
    }

}