//
//  RockScissorsPaperTests.swift
//  RockScissorsPaperTests
//
//  Created by Игорь Пенкин on 18.09.2020.
//  Copyright © 2020 Igor-A-Penkin. All rights reserved.
//

import XCTest
@testable import RockScissorsPaper

class RockScissorsPaperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let sign = Sign.rock
        print(sign)
        print(sign.emoji)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRockSign() {
        let sign = Sign.rock
        XCTAssert(sign.getResult(for: .rock) == .draw)
        XCTAssert(sign.getResult(for: .paper) == .lose)
        XCTAssert(sign.getResult(for: .scissors) == .win)
    }
    
    func testPaperSign() {
        let sign = Sign.paper
        XCTAssert(sign.getResult(for: .rock) == .win)
        XCTAssert(sign.getResult(for: .paper) == .draw)
        XCTAssert(sign.getResult(for: .scissors) == .lose)
    }
    
    func testScissorsSign() {
        let sign = Sign.scissors
        XCTAssert(sign.getResult(for: .rock) == .lose)
        XCTAssert(sign.getResult(for: .paper) == .win)
        XCTAssert(sign.getResult(for: .scissors) == .draw)
    }
}
