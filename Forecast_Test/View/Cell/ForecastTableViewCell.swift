//
//  ForecastTableViewCell.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-15.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    //MARK: - Outlets

    @IBOutlet weak var firstIcon: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondIcon: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var view: UIView!

    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10.0
    }

    //MARK: - Set Up

    func setUp(firstImage: UIImage,
               firstTemp: String,
               secondImage: UIImage,
               secondTemp: String,
               thirdImage: UIImage,
               thirdTemp: String) {
        firstIcon.image = firstImage
        firstLabel.text = firstTemp
        secondIcon.image = secondImage
        secondLabel.text = secondTemp
        thirdIcon.image = thirdImage
        thirdLabel.text = thirdTemp
    }
    
}
