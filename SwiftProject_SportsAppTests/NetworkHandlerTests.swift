//
//  NetworkHandlerTests.swift
//  SwiftProject_SportsAppTests
//
//  Created by Ahmed Abu-zeid on 03/02/2024.
//

import XCTest
@testable import SwiftProject_SportsApp

final class NetworkHandlerTests: XCTestCase {
    var networkHandler = NetworkHandler()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testFetch(){
        networkHandler.fetch(url: APIHandler.getURLFor(sport: "football", get: .allLeagues), type: Leagues.self) { leaguesContainer in
            XCTAssertNotNil(leaguesContainer, "leaguesContainer came empty")
        }
    }

}
