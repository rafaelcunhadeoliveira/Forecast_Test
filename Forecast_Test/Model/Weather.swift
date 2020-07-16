//
//  Weather.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-14.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

/*
   Decodable Objects to help Deserialize service response
*/

struct Forecast: Decodable {
    var list: [ForecastByDate]?
    var cod: String?
    var city: City?
    var message: Int?

    enum CodingKeys: String, CodingKey {
        case list = "list"
        case cod
        case city
        case message
    }
}

struct ForecastByDate: Decodable {
    var date: String?
    var weather: [Weather]?
    var main: Main?

    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case weather
        case main
    }
}

struct WeatherStats: Decodable {
    var city: String?
    var tempAttributes: Main?
    var weather: [Weather]?
    var cod: Int?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case city = "name"
        case tempAttributes = "main"
        case weather = "weather"
        case cod
        case message
    }
}

struct Weather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init(id: Int,
         main: String,
         desc: String,
         icon: String) {
        self.id = id
        self.main = main
        self.description = desc
        self.icon = icon
    }
    
    enum CodingKeys: String, CodingKey {
        case id, main, description, icon
    }
}

struct Main: Decodable {
    var temp: Double?
    var feelsLike: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Double?
    var humidity: Double?
    
    init(temp: Double,
         feelsLike: Double,
         tempMin: Double,
         tempMax: Double,
         pressure: Double,
         humidity: Double) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
    }
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct City: Decodable {
    var country: String?

    enum CodingKeys: String, CodingKey {
        case country
    }
}
