//
//  Aleerts.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import Foundation
import  UIKit
class Alerts {
    
    static func show(msg : String , vc : UIViewController) {
        if vc.presentedViewController == nil {
            let alert:UIAlertController=UIAlertController(title: "Message", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                vc.present(alert, animated: true, completion: nil)
            }
        }
    }
}
