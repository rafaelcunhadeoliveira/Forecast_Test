//
//  String+Extension.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-16.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date { // convert string to date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatterGet.date(from: self) {
            return date
        } else {
           print("There was an error decoding the string")
            return Date()
        }
    }
}
