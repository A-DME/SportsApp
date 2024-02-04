//
//  APIHandlerTests.swift
//  SwiftProject_SportsAppTests
//
//  Created by Ahmed Abu-zeid on 03/02/2024.
//

import XCTest
@testable import SwiftProject_SportsApp


final class APIHandlerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetURLForAllLeagues(){
        let url = APIHandler.getURLFor(sport: "football", get: .allLeagues)
        XCTAssertTrue(url == "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(APIHandler.myKey)", "URL Doesn't generate successfully")
    }
    func testGetURLForLeague(){
        let urlUp = APIHandler.getURLFor(sport: "football", get: .leagueEvents, leagueDetails: ( 4 , .upcoming))
        let urlLate = APIHandler.getURLFor(sport: "football", get: .leagueEvents, leagueDetails: ( 4 , .latest))
        XCTAssertTrue(urlUp == APIHandler.getURLFor(sport: "football", get: .leagueEvents, leagueDetails: ( 4 , .upcoming)), "URL for upcoming Doesn't generate successfully")
        XCTAssertTrue(urlLate == APIHandler.getURLFor(sport: "football", get: .leagueEvents, leagueDetails: ( 4 , .latest)), "\nURL for latest Doesn't generate successfully\n")
    }
    func testGetURLForTeam(){
        let url = APIHandler.getURLFor(sport: "football", get: .team, teamKey: 110)
        XCTAssertTrue(url == "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=110&APIkey=\(APIHandler.myKey)", "URL Doesn't generate successfully")
    }
    
    func testGetDate(){
        let date = APIHandler.getDateOf(.currentYear)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let result: String = dateFormatter.string(from: Date())
        
        XCTAssertTrue(date == result , "Date not computed properly")
    }

}
