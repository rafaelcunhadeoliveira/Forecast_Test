//
//  ServiceRequest .swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-14.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation
import Alamofire

class ServiceRequest: RequestBase {
    func getWeatherForCity(_ city: String,
                           success: @escaping(WeatherStats) -> Void,
                           failure: @escaping(CustomError) -> Void) { // current weather for the city
        guard let url = buildUrl(.currentWeather, id: city) else { return }
        AF.request(url,
                   method: .get,
                   encoding: self.encoding).responseData { (response) in
                    if let error = response.error {
                        
                        failure(CustomError(description: error.localizedDescription,
                                            code: error.responseCode ?? 400))
                    } else {
                        do {
                            let weather: WeatherStats = try JSONDecoder().decode(WeatherStats.self, from: response.data ?? Data())
                            if let message = weather.message {
                                failure(CustomError(description: message,
                                                    code: weather.cod ?? 400))
                                return
                            }
                            success(weather)
                        } catch {
                            failure(CustomError(description: "City not found",
                                                code: 404))
                        }
                    }
        }
    }
    
    func getForecast(_ city: String,
                     success: @escaping(Forecast) -> Void,
                     failure: @escaping(CustomError) -> Void) { // forecast service for the next days
        guard let url = buildUrl(.fiveDaysForecast, id: city) else { return }
        AF.request(url,
                   method: .get,
                   encoding: self.encoding).responseData { (response) in
                    if let error = response.error {
                        failure(CustomError(description: error.localizedDescription,
                                            code: error.responseCode ?? 400))
                    } else {
                        do {
                            let forecast: Forecast = try JSONDecoder().decode(Forecast.self, from: response.data ?? Data())
                            if Int(forecast.cod ?? "") ?? 0 > 300 {
                                failure(CustomError(description: "City not found",
                                                    code: 404))
                                return
                            }
                            success(forecast)
                        } catch {
                            failure(CustomError(description: "City not found",
                                                code: 404))
                        }
                    }
        }
    }
    
    func getImage(url: String) -> UIImage { // download Image by URL and by ID
        return UIImage(url: URL(string: url)) ?? UIImage()
    }
    
    func getImage(id: String) -> UIImage {
        return UIImage(url: buildUrl(.icons, id: id)) ?? UIImage()
    }
    
    func getNewsByCountry(_ country: String,
                          success: @escaping(News) -> Void,
                          failure: @escaping(CustomError) -> Void) { // news service for the country
        guard let url = buildUrl(.headlines, id: country) else { return }
        AF.request(url,
                   method: .get,
                   encoding: self.encoding).responseData { (response) in
                    if let error = response.error {
                        failure(CustomError(description: error.localizedDescription,
                                            code: error.responseCode ?? 400))
                    } else {
                        do {
                            let news: News = try JSONDecoder().decode(News.self, from: response.data ?? Data())
                            success(news)
                        } catch {
                            failure(CustomError(description: "City not found",
                                                code: 404))
                        }
                    }
        }
    }
}
