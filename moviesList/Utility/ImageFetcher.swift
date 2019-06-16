//
//  ImageFetcher.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import UIKit
class ImageFetcher {
    
static let shared = ImageFetcher()
// its better to use some advanced criteria to cash images ex enqueue for disposing them
var imageCach = [String:UIImage]()
    
func downloadImage(from urlString: String , onComplete: @escaping (UIImage)->Void , onError:@escaping (String?)->Void) {
    guard let url = URL(string: urlString)  else {
        onError("err.invalidUrl")
        return
    }
    if let cachedImage = imageCach[urlString] {
        DispatchQueue.main.async {

        onComplete(cachedImage)
        }
        return
    }
    
    APIProvider.shared.getData(from: url) { data, response, error in
        guard let data = data, error == nil else {
            onError("err.noData")
            return
        }
        if let img =  UIImage(data:data)
        {
          self.imageCach[urlString] = img
            DispatchQueue.main.async {

          onComplete(img)
            }
        }
        else {
            onError("err.dataCorrupted")
        }
    }
}
}
