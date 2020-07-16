//
//  RequestBase.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-14.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation
import Alamofire

public enum UrlRequest: String { // enum URLs
    case currentWeather = "https://api.openweathermap.org/data/2.5/weather"
    case fiveDaysForecast = "https://api.openweathermap.org/data/2.5/forecast"
    case icons = "http://openweathermap.org/img/w/"
    case headlines = "https://newsapi.org/v2/top-headlines"
}

public enum KeyRequest: String { // keys provided
    case bugsnagApiKey = "c50de95d8fb5eb28044f06fca832a8eb"
    case newsApiKey = "af4dd8433ecd4b8bad04138007900385"
    case weatherApiKey = "6ad6726f4d3d745e204889063cf30fbf"
}

open class RequestBase {

    public let encoding = JSONEncoding.default // default encoding for the service

    func buildUrl(_ request: UrlRequest, id: String ) -> URL? { // URL Factory acording to the service
        switch request {
        case .currentWeather, .fiveDaysForecast:
            guard var url = URLComponents(string: request.rawValue) else { return nil }
            let city = id.replacingOccurrences(of: " ", with: "+")
            url.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: KeyRequest.weatherApiKey.rawValue),
                URLQueryItem(name: "units", value: "metric")
            ]
            return url.url
        case .headlines:
            guard var url = URLComponents(string: request.rawValue) else { return nil }
            let country = id.lowercased()
            url.queryItems = [
                URLQueryItem(name: "q", value: country),
                URLQueryItem(name: "apiKey", value: KeyRequest.newsApiKey.rawValue)
            ]
            return url.url
        case .icons:
            return URL(string: "\(request.rawValue)\(id).png")
        }
    }
}

struct CustomError {

    var title: String?
    var code: Int
    var description: String

    init(title: String = "Ops",
         description: String,
         code: Int) {
        self.title = title
        self.description = description
        self.code = code
    }
}
