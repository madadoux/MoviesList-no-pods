//
//  Date+toString.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation

extension Date {
    func getString()->String  { let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateAsString = formatter.string(from:self )
        return dateAsString
    }
}
