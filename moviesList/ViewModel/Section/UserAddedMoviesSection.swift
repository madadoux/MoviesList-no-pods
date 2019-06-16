//
//  InternetMoviesSection.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import UIKit
class UserAddedMoviesSection : TableSectionProtocol  {
    private var elements : [Movie]
    private var title : String
    init(elements: [Movie], title: String ) {
        self.elements = elements
        self.title = title
    }
    
    func getTitle() -> String {
        return  "Added movies"
    }
    
    func addElements (_ elements : [Movie] ) {
        self.elements.append(contentsOf:elements)
    }
    func getCellAtIndex(tableView: UITableView, Index: Int) -> BaseCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id) as? MovieCell{
            let movie = self.elements[Index]
            cell.model = movie
            return cell
        }
        return BaseCell()
    }
    
    func getHeight(Index: Int) -> CGFloat {
        return MovieCell.height
    }
    
    func getNumberOfRows() -> Int {
        return elements.count
    }
    
    
}
