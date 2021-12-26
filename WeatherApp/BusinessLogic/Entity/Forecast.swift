//
//  Forecast.swift
//  
//
//  Created by Vladimir Pulkhrov on 22.11.2021.
//

import Foundation

struct Forecast {
    
    let weathers: [[Weather]]
    
    init(rawWeaterData: [String:Any]) throws {
        guard let dictList = rawWeaterData["list"] as? [[String : Any]],
           let townData = rawWeaterData["city"] as? [String:Any],
           let town = townData["name"] as? String
        else {
            throw SystemError.weatherInitIssue
        }
                
        let weather : [Weather] = try dictList.map { (rawData) -> Weather in
            var weather = try Weather(rawWeaterData: rawData)
            weather.town = town
            return weather
        }
        
        var filteredWeathers: [[Weather]] = []
        var dayForecast: [Weather] = []

        guard let rawDate = weather.first else {
            throw SystemError.weatherInitIssue
        }
        
        let calendar = Calendar.current
        var day = calendar.component(.day, from: rawDate.date)
        for index in 0..<weather.count {
            if day == calendar.component(.day, from: weather[index].date) {
                dayForecast.append(weather[index])
            } else {
                day = calendar.component(.day, from: weather[index].date)
                filteredWeathers.append(dayForecast)
                dayForecast = []
                dayForecast.append(weather[index])
            }
        }
        self.weathers = filteredWeathers
    }
}

