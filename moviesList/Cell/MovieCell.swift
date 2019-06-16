//
//  MovieCell.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import UIKit
class  BaseCell : UITableViewCell  {
    class var height: CGFloat {get{return 0}}
    class var id : String { get{ return "" }}
}

class MovieCell: BaseCell {
    override class var height: CGFloat { get{ return 200.0}}
    override class var id : String { get{ return "movieCell" }}
    
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overView: UILabel!


    fileprivate func setDefaultImg() {
        DispatchQueue.main.async {
        self.posterImage.image = UIImage(named :"defaultPoster")
        }
    }
    
    var model : Movie? {
        didSet {
            title.text = model?.title
            date.text = model?.release_date
            overView.text = model?.overview
            //user added movie
            if let image = model?.posterImage {
                self.posterImage.image = image
                return
            }
            
            setDefaultImg()
            if let posterUrl = model?.poster_path {
                ImageFetcher.shared.downloadImage(from: "https://image.tmdb.org/t/p/w185\(posterUrl)", onComplete: { [weak self] (img) in
                    self?.posterImage.image = img
                    
                }, onError: { [weak self ] (err) in
                    self?.setDefaultImg()
                })
            }
            else {
                setDefaultImg()
            }
        }
    }
   

}
