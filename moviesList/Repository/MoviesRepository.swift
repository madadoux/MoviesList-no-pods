//
//  MoviesRepository.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation

class MoviesRepository {
    private static let baseURl = "http://api.themoviedb.org"
    static func getMovies(page : Int , onSucess : @escaping ([Movie], Int?)-> Void , onError:@escaping (String?)->Void )
    {
        APIProvider.shared.get(url: "\(baseURl)/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=\(page)", onComplete: { (response: MovieGetResponse) in
            
            if let movies = response.results {
                
                onSucess(movies, response.total_pages);
            }
            else {
                onError("error.parsingError")
            }
            
        } , onError : onError)
    }
    
}

