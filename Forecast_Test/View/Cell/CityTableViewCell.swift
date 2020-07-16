//
//  CityTableViewCell.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-15.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    //MARK: - Outlets

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!

    //MARK: - Set Up

    func setUp(name: String,
               maxMinTemp: String,
               current: String,
               image: UIImage) {
        cityNameLabel.text = name
        maxMinTempLabel.text = maxMinTemp
        currentTempLabel.text = current
        icon.image = image
    }
}
