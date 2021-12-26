//
//  WeatherInfoService.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import Foundation
import Alamofire
import CoreLocation

protocol WeatherInfoServiceProtocol {
    func getTodaysWeather(location:CLLocation, completionHandler: @escaping (Weather?, Error?) -> Void)
    func weatherForecast(location:CLLocation, completionHandler: @escaping ([[Weather]]? , Error?) -> Void)
}

class WeatherInfoService: WeatherInfoServiceProtocol {
    
    static var shared: WeatherInfoServiceProtocol = WeatherInfoService()
    
    private let APIKey: String =  "6280a178e5240067498de48a3856fafe"
    
    func getTodaysWeather(location:CLLocation , completionHandler: @escaping (Weather?, Error?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let params: Parameters = ["lat" : lat, "lon" : lon, "appid" : APIKey]
        
        AF.request(url, method: .get , parameters: params).validate().response { (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data, let rawWeaterData = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        throw SystemError.jsonError
                    }
                    let weather = try Weather(rawWeaterData: rawWeaterData)
                    completionHandler(weather, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func weatherForecast(location:CLLocation ,completionHandler: @escaping ([[Weather]]? , Error?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/forecast"
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let params: Parameters = ["lat" : lat , "lon" : lon, "appid" : APIKey]
        
        AF.request(url, method: .get , parameters: params).validate().response { (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let forecastData = data,
                          let rawWeaterData = try JSONSerialization.jsonObject(with: forecastData) as? [String : Any]
                    else {
                        throw SystemError.jsonError
                    }
                    let weatherForecast: [[Weather]] = try Forecast(rawWeaterData: rawWeaterData).weathers
                    completionHandler(weatherForecast, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil , error)
            }
        }
    }
}

