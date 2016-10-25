//
//  SamplerInstrument.swift
//  Allegro
//
//  Created by Sam Williams on 12/14/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import Foundation
import AVFoundation

open class SamplerInstrument: Instrument {
    open var filename:String
    open var patchNumber:UInt8
    open var bank:UInt8 = UInt8(kAUSampler_DefaultMelodicBankMSB)
    
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
    
    override func startPlayingPitch(_ pitch:Pitch, loudness:Loudness) {
        self.sampler.startNote(pitch.MIDINumber, withVelocity: loudness.MIDIVelocity, onChannel: 0)
    }
    
    override func stopPlayingPitch(_ pitch:Pitch) {
        self.sampler.stopNote(pitch.MIDINumber, onChannel: 0)
    }
    
    // MARK: - MIDI
    
    private func setup() throws {
        self.engine.attach(self.sampler)
        self.engine.connect(self.sampler, to: self.engine.outputNode, format: nil)
        
        if let soundbankURL = Bundle.main.url(forResource: self.filename, withExtension: "sf2") {
            try self.engine.start()
            try self.sampler.loadSoundBankInstrument(at: soundbankURL, program: self.patchNumber, bankMSB: self.bank, bankLSB: 0)
        }
    }
    
    
    open override func stop() {
        super.stop()
        for i in MIDI.MinimumMIDINumber..<MIDI.MaximumMIDINumber {
            self.sampler.stopNote(i, onChannel: 0)
        }
    }

}
