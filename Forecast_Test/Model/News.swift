//
//  News.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-15.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

/*
    Decodable Objects to help Deserialize service response
 */

struct News: Decodable {
    var status: String?
    var articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case status
        case articles
    }
}

struct Article: Decodable {
    var source: Source?
    var title: String?
    var urlToImage: String?

    enum CodingKeys: String, CodingKey {
        case source
        case title
        case urlToImage
    }
}

struct Source: Decodable {
    var id: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
