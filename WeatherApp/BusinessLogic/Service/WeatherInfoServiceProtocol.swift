//
//  WeatherInfoServiceProtocol.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import Foundation


protocol WeatherInfoServiceProtocol {
    func getTodaysWeather(completionHandler: @escaping (Weather?, Error?) -> Void)
}
