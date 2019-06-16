//
//  moviesListTests.swift
//  moviesListTests
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import XCTest
@testable import moviesList

class moviesListTests: XCTestCase {
    var moviesViewModel = MoviesViewModel()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moviesViewModel = MoviesViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoviesGet() {
    
    let moviesConutexp = expectation(description: "movies count")
        moviesViewModel.getNextMovies()
        self.moviesViewModel.onMoviesChanged = { [unowned self] in
            XCTAssert(self.moviesViewModel.moviesSection.getNumberOfRows() > 0 , "api should reutrn  movies")
            moviesConutexp.fulfill()
        }
        self.moviesViewModel.onError = { err in
            XCTFail("err\(err ?? "")")
            moviesConutexp.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testNoMoreMovies() {
        let moviesGetExp = expectation(description: "movies get")
        
        var totalPages = -1
        moviesViewModel.getNextMovies()

        self.moviesViewModel.onMoviesChanged = { [unowned self] in
            
            if ( totalPages == -1 )
            {
                totalPages = self.moviesViewModel.totalPages
                self.moviesViewModel.currentPage = totalPages
                self.moviesViewModel.getNextMovies()

            }
            else {
            XCTAssert(self.moviesViewModel.haveMoreItems() == false , "have more items while reaching the last page")
            moviesGetExp.fulfill()
            }

        }
        
        self.moviesViewModel.onError = { e in
            XCTAssert(self.moviesViewModel.haveMoreItems() == false , "have more items while reaching the last page")
            moviesGetExp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testAddMovie() {
        self.moviesViewModel.addMovie(movie: Movie(title: "test", overview: "test", releaseDate: "12-21-1998", image: nil))
        XCTAssert(self.moviesViewModel.getSectionCount() == 2 , "sections should be 2")
        XCTAssert(self.moviesViewModel.getSectionAt(section: 0) is UserAddedMoviesSection, "should be user added section")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
