//
//  LoadingCell.swift
//  moviesList
//
//  Created by mohamed saeed on 6/16/19.
//  Copyright © 2019 mohamed saeed. All rights reserved.
//

import UIKit

class LoadingCell: BaseCell {
    override class var id: String { get { return "loadingCell"}}
    override class var height: CGFloat {get{ return 100.0 }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
