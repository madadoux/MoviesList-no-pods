//
//  moviesListUITests.swift
//  moviesListUITests
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import XCTest

class moviesListUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddMovie() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let addBtn  = app.buttons["add movie"]
        addBtn.tap()
        
    
        let movieTitleTextField = app.textFields["Movie Title"]
        movieTitleTextField.tap()
        movieTitleTextField.typeText("title")
        
        let movieOverviewTextField = app.textFields["Movie OverView"]
        movieOverviewTextField.tap()
        movieOverviewTextField.typeText("r")
        movieOverviewTextField.tap()
        movieOverviewTextField.tap()
        movieOverviewTextField.typeText("rwer")
        movieOverviewTextField.tap()
        app.buttons["Add"].tap()
        
        let tablesQuery = app.tables
        let title = tablesQuery.staticTexts["title"].exists
        XCTAssertTrue(title,
                      "Failure: Something went wrong.")

    }
    
    
    func testLoadMore() {
        let app = XCUIApplication()
        var c = 5
        
        while  c > 0 {
            app.swipeUp()
            c = c - 1
        }
        
        let tablesQuery = app.tables
        let count = tablesQuery.tableRows.count
        let loadedMore = count > 20
        XCTAssertTrue(loadedMore,
                      "Failure: Something went wrong.")

    }
    
}
