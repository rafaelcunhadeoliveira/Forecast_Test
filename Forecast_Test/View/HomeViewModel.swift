//
//  HomeViewModel.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-15.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

/*
 VMMV Architecture, where all the information are provided by the view model
 */

enum NumberDays: Int { // enum used to provide the next day requested
    case first = 1
    case second = 2
    case third = 3
}

class HomeViewModel {

    // MARK: - Variables

    var service = ServiceRequest()
    var weather: WeatherStats?
    var forecast: Forecast?
    var news: News?
    var mainGroup = DispatchGroup() // Dispatch groups to assure all info required is present
    var secondaryGroup = DispatchGroup()
    var errorMessage: CustomError?
    var city: String = "-"

    // MARK: - Service Requests

    func getInfo(_ city: String,
                 success: @escaping() -> Void,
                 failure: @escaping(CustomError) -> Void) { // Request's controller
        errorMessage = nil
        self.city = city
        getWeather(city)
        fiveDayForecast(city)
        mainGroup.notify(queue: .main) {
            if let error = self.errorMessage {
                failure(error)
                return
            }
            self.searchSecondaryInfo(success: {
                success()
            }) { (error) in
                failure(error)
            }
        }
    }

    func searchSecondaryInfo(success: @escaping() -> Void,
                             failure: @escaping(CustomError) -> Void) { // Request's controller
        guard let country = forecast?.city?.country else { return }
        getNews(country)
        secondaryGroup.notify(queue: .main) {
            if let error = self.errorMessage {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    func getWeather(_ city: String) {
        mainGroup.enter()
        service.getWeatherForCity(city,
                                  success: { (weather) in
                                    self.weather = weather
                                    self.mainGroup.leave()
        }) { (error) in
            self.errorMessage = error
            self.mainGroup.leave()
        }
    }

    func fiveDayForecast(_ city: String) {
        mainGroup.enter()
        service.getForecast(city,
                                  success: { (response) in
                                    self.forecast = response
                                    self.mainGroup.leave()
        }) { (error) in
            self.errorMessage = error
            self.mainGroup.leave()
        }
    }

    func getNews(_ country: String) {
        secondaryGroup.enter()
        service.getNewsByCountry(country,
                                 success: { (response) in
                                    self.news = response
                                    self.secondaryGroup.leave()
        }) { (error) in
            self.errorMessage = error
            self.secondaryGroup.leave()
        }
    }

    // MARK: - Adapt Information

    func getImage(url: String) -> UIImage {
        return service.getImage(url: url)
    }

    func getImage(id: String) -> UIImage {
        return service.getImage(id: id)
    }

    func getMaxMinTemp() -> String {
        guard let max = weather?.tempAttributes?.tempMax,
            let min = weather?.tempAttributes?.tempMin else { return "max - / min -" }
        return "max \(String(format: "%.0f", max)) / min \(String(format: "%.0f", min))"
    }

    func getCurrentTemp() -> String {
        guard let current = weather?.tempAttributes?.temp else { return "Current: -"}
        return "Current: \(String(format: "%.0f", current))"
    }

    func formatDateForecast(_ max: Double, _ min: Double) -> String{
        return "\(String(format: "%.0f", max)) / \(String(format: "%.0f", min))"
    }

    func getNextDateForecast(_ day: NumberDays) -> ForecastByDate? {
        let interval: Double = Double((day.rawValue*60*60*24))
        let nextDay = Date().advanced(by: interval)
        guard let list = forecast?.list else { return nil }
        for obj in list {
            if obj.date?.toDate() ?? Date() > nextDay {
                return obj
            }
        }
        return nil
    }
}
