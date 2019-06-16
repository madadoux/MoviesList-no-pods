//
//  AppStoryboards.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import UIKit
enum AppStoryBoard : String {
    case Main
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func viewController < T: UIViewController> (viewControllerClass : T.Type) -> T {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyBoardID
        return instance.instantiateViewController(withIdentifier: storyBoardID) as! T
    }
    func initialViewController () -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}


extension UIViewController {
    class var storyBoardID  : String {
        return "\(self)"
    }
    
    static func initiateFromAppStoryBoard(_ storyBoard : AppStoryBoard)-> Self {
        return storyBoard.viewController(viewControllerClass: self)
    }
}
