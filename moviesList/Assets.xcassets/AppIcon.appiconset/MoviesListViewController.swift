//
//  MoviesListViewController.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import UIKit
class MoviesListViewController : UIViewController {
    
    var moviesViewModel = MoviesViewModel()
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var tabBarButton : UIBarButtonItem!
    
    fileprivate func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: LoadingCell.id)
         tableView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.id)
    }
    
    func initObservers() {
        self.moviesViewModel.onMoviesChanged = { [unowned self ] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.moviesViewModel.onError = {e in
            if let err = e {
                Alerts.show(msg: err, vc: self)
                print(err)
            }
        }
    }
    
    override func viewDidLoad() {
     super.viewDidLoad()
     setupUI()
     initObservers()
     self.moviesViewModel.getNextMovies()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    @IBAction func addMovie () {
        let addMoviesVC = AddMovieViewController.initiateFromAppStoryBoard(.Main)
        
           addMoviesVC.moviesViewModel = moviesViewModel
        navigationController?.pushViewController(addMoviesVC, animated: true)
        
    }
    
}


extension MoviesListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let section =  self.moviesViewModel.getSectionAt(section: indexPath.section) , section is MoviesTableSection , indexPath.row == section.getNumberOfRows() - 1 {
            self.moviesViewModel.getNextMovies()
        }
       
    }
}

extension MoviesListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let section =  self.moviesViewModel.getSectionAt(section: section) {
            return section.getTitle()
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let section =  self.moviesViewModel.getSectionAt(section: indexPath.section) {
            return section.getHeight(Index: indexPath.row)
        }
        return 0
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.moviesViewModel.getSectionCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let section =  self.moviesViewModel.getSectionAt(section: indexPath.section) {
            return section.getCellAtIndex(tableView: tableView, Index: indexPath.row)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let section =  self.moviesViewModel.getSectionAt(section: section) {
            return section.getNumberOfRows()
        }
        return 0
    }
}

