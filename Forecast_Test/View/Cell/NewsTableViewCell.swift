//
//  NewsTableViewCell.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-15.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: - Outlets

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    //MARK: - Set Up

    func setUp(image: UIImage,
               title: String,
               source: String) {
        articleImage.image = image
        titleLabel.text = title
        sourceLabel.text = source
    }
    
}
