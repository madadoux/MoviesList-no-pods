//
//  MoviesViewModel.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import UIKit
class MoviesViewModel {
    var currentPage : Int = 1
    var totalPages : Int = Int.max
    
    // dynmaic sections to avoid if else hassel  to return number of rows for each section , cells and presence of section or not
    var tableViewSections  = [TableSectionProtocol]()
    
    let moviesSection = MoviesTableSection(elements: [], title: "All Movies")
    var userAddedSection : UserAddedMoviesSection?
    
    //this will be better if we used rxSwift
    var onMoviesChanged : (()->Void)?
    var onError: ((String?)->Void)?
    
    private var isLoading = false
    init() {
        tableViewSections.append(moviesSection)
    }
    
    func getNextMovies() {
        if !isLoading {
        MoviesRepository.getMovies(page: currentPage, onSucess: { [unowned self] (movies,totalPages) in
            self.isLoading = false
            self.moviesSection.addElements( movies)
            self.currentPage = self.currentPage + 1
            self.totalPages = totalPages ?? Int.max
            self.onMoviesChanged?()
            }, onError: { [unowned self] err in
                self.onError?(err)
        })
        }
    }
    
    func haveMoreItems() ->Bool {
        return currentPage < totalPages
    }
    // this will get the appropriate section for index
    func getSectionAt(section : Int )->TableSectionProtocol? {
        if let index = self.tableViewSections.index(0, offsetBy: section, limitedBy: self.tableViewSections.count - 1 ) {
            return self.tableViewSections[index]
        }
        else {return nil}
    }

    func getSectionCount() -> Int {
        return self.tableViewSections.count
    }
    
    
    func addMovie( movie : Movie ) {
        if self.tableViewSections.count < 2 {
            let userAddedSection = UserAddedMoviesSection(elements: [], title: "Added Movies")
            self.tableViewSections.insert(userAddedSection, at: 0)
            self.userAddedSection = userAddedSection
        }
        
        self.userAddedSection!.addElements([movie])
        onMoviesChanged?()
    }
    
}
