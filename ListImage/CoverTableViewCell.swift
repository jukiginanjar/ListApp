//
//  CoverTableViewCell.swift
//  ListImage
//
//  Created by Nanang Rafsanjani on 14/03/19.
//  Copyright © 2019 Nanang Rafsanjani. All rights reserved.
//

import UIKit

class CoverTableViewCell: UITableViewCell {
    @IBOutlet private var coverView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    var cover: Cover? {
        didSet {
            titleLabel.text = cover?.title
            guard let url = URL(string: cover?.imageUrl ?? "") else {
                return
            }
            coverView.setImageWithURL(url)
        }
    }
}
