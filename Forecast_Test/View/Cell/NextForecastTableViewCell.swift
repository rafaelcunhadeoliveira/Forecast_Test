//
//  NextForecastTableViewCell.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-15.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class NextForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var firstIcon: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondIcon: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var thirdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

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
