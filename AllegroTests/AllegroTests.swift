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
        XCTAssertEqual(PitchClass.C♯, PitchClass.Csharp)
        XCTAssertEqual(PitchClass.C♭, PitchClass.B)
        
        XCTAssertEqual(PitchClass.Dflat, PitchClass.Csharp)
    }
    
}
