//
//  Weather.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import Foundation

struct Weather {
    
    var kelvin: Double = 273.15
    var town: String?
    var temperature: Double
    
    var date: Date
    
    var windSpeed: Double
    var humidity: Int
    var pressure: Int
    var rainProbability: Int
    var clowdness: Int
    
    var icon: URL
    
    init(rawWeaterData: [String:Any]) throws {
        guard let weatherMain = rawWeaterData["main"] as? [String: Any],
              let temperatureF = weatherMain["temp"] as? Double,
              let humidity = weatherMain["humidity"] as? Int,
              let pressure = weatherMain["pressure"] as? Int,
              
              let weatherClowds = rawWeaterData["clouds"] as? [String: Any],
              let clowdness = weatherClowds["all"] as? Int,
              let rainProbability = weatherClowds["all"] as? Int, // не нашел это костыль
              
              
              let weatherWind = rawWeaterData["wind"] as? [String: Any],
              let windSpeed = weatherWind["speed"] as? Double,
              
              let weatherWeather = rawWeaterData["weather"] as? [Any],
              let iconPrep = weatherWeather.first as? [String: Any],
              let iconRaw = iconPrep["icon"] as? String,
              
              let time = rawWeaterData["dt"] as? Double
        else {
            throw SystemError.weatherInitIssue
        }
    
        guard let icon = URL(string: "https://openweathermap.org/img/wn/" + iconRaw + ".png") else {
            throw SystemError.weatherInitIssue
        }
        
        let temperature = Double(round(10 * (temperatureF - kelvin)) / 10)
        self.town = rawWeaterData["name"] as? String

        self.windSpeed = windSpeed
        
        self.temperature = temperature
        self.humidity = humidity
        self.clowdness = clowdness
        self.windSpeed = windSpeed
        self.icon = icon
        self.pressure = pressure
        self.date = Date(timeIntervalSince1970: time)
        self.rainProbability = rainProbability
        
    }
}

