//
//  TodaysWeatherIO.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import Foundation

protocol TodaysWeatherViewInput: UIViewInput {
    func update(weather: Weather)
    func startLoad()
    func finishLoad()
}

protocol TodaysWeatherViewOutput: AnyObject {
    func viewIsReady()
}
