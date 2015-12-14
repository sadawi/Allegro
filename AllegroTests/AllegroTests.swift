//
//  AllegroTests.swift
//  AllegroTests
//
//  Created by Sam Williams on 12/4/15.
//  Copyright © 2015 Sam Williams. All rights reserved.
//

import XCTest
@testable import Allegro

class AllegroTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPitches() {
        XCTAssertEqual(C♯, C.sharp)
        XCTAssertEqual(C♭, B)
        
        XCTAssertEqual(D.flat, C.sharp)
        
        let pitch:Pitch = C.sharp.pitch(0)
        let pitch2:Pitch = C.sharp[0]
        XCTAssertEqual(pitch.semitonesFromBase, 1)
        XCTAssertEqual(pitch2.semitonesFromBase, 1)

        let note = C.sharp.pitch(0).note(Duration.Quarter)
        XCTAssertEqual(note.duration, Duration.Quarter)
        
        let note2:Note = C.sharp[0]/4
        XCTAssertEqual(note2.duration, Duration.Quarter)
        
        
        XCTAssertEqual(B.sharp[5].octave, 5)
        XCTAssertEqual(B.flat[2].pitchClass, B.flat)
    }
    
    func testScales() {
        let scale = D.majorScale
        let pitchClasses = scale.pitchClasses()
        let desiredPitchClasses = [D, E, F♯, G, A, B, C♯]
        XCTAssertEqual(pitchClasses, desiredPitchClasses)
        
        let pitches = scale.pitchesStartingWithPitch(D[4])
        XCTAssertEqual(pitches[0], D[4])
        
        let octave4 = scale.pitchesStartingInOctave(4)
        XCTAssertEqual(octave4[0], D[4])
        
        let triad = scale.triadFromPitch(D[4])
        XCTAssertNotNil(triad)
        XCTAssertEqual(triad!.pitches, [D[4], F.sharp[4], A[4]])
    }
    
    func testNotes() {
        let note = D[4]/4
        XCTAssertEqual(note.duration, Duration.Quarter)
        XCTAssertEqual(note.duration, 𝅘𝅥)
    }
    
    func testRests() {
        let note = D[4]/4
        let rest = note.duration.rest
        XCTAssertEqual(rest.duration, Duration.Quarter)
        
        XCTAssertEqual(𝄽, Duration.Quarter.rest)
    }
    
    func testExpressions() {
        let expression:SequenceExpression = [ D[4]/4, A[4]/16 ]
        let first = expression.expressions[0] as! Note
        XCTAssertEqual(first, D[4]/4)
        
        XCTAssertEqual(expression.duration, Duration.Quarter + Duration.Sixteenth)
        
        let parallel: ParallelExpression = [ C[4]/4, E[4]/4 ]
        XCTAssertEqual(parallel.duration, Duration.Quarter)
    }
}
