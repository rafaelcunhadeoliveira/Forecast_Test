//
//  Image+Extension.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-16.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

extension UIImage { // Download Image
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
