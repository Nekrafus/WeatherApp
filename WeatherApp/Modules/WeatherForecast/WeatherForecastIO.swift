//
//  WeatherForecastIO.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import Foundation

protocol WeatherForecastViewInput: UIViewInput {
    func setupInitialState()
    func updateTableView()
    func startLoad()
    func finishLoad() 
}

protocol WeatherForecastViewOutput: AnyObject {
    var weathers: [[Weather]] { get }

    func viewIsReady()
}
