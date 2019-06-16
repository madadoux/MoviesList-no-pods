//
//  TableViewSection.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import UIKit
protocol TableSectionProtocol{
    func getTitle() -> String
    func getCellAtIndex(tableView : UITableView , Index :Int ) -> BaseCell
    func getHeight(Index : Int ) -> CGFloat
    func getNumberOfRows() -> Int
}
