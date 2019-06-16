//
//  AddMovieViewController.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import  UIKit


class AddMovieViewController : ImagePickerViewController {
    var moviesViewModel : MoviesViewModel!
    
    
    
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieOverview: UITextField!
    @IBOutlet weak var movieDate: UIDatePicker!
    @IBOutlet weak var submitButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
    }
    @objc func submit() {
    moviesViewModel.addMovie(movie: Movie(title: movieTitle.text ?? "", overview: movieOverview.text ?? "" , releaseDate:  movieDate.date.getString(), image: image.image))
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
