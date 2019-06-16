//
//  UserAddedSection.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import UIKit
class MoviesTableSection : TableSectionProtocol{
    
    
    private var elements : [Movie]
    private var title : String
    init(elements: [Movie], title: String ) {
        self.elements = elements
        self.title = title
    }
    
    func getTitle() -> String {
        return title
    }
    
    func addElements (_ elements : [Movie] ) {
        self.elements.append(contentsOf:elements)
    }
    
    func getCellAtIndex(tableView : UITableView , Index index:Int) -> BaseCell {
        if ( index < self.elements.count ){
            if   let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id) as? MovieCell{
                let movie = self.elements[index]
                cell.model = movie
                return cell
            }
            
        }
        else if ( index == self.elements.count ){
            if let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.id) as? LoadingCell{
                return cell
            }
        }
        return BaseCell()
        
    }
    
    func getHeight(Index: Int) -> CGFloat {
        if ( Index < self.elements.count ){
            return MovieCell.height
        }
        else if (Index == self.elements.count ){
            return LoadingCell.height
        }
        return 0
    }
    
    func getNumberOfRows() -> Int {
        let count = self.elements.count + 1
        return count
    }
}
