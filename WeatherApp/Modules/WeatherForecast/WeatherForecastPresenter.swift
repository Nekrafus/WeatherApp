//
//  WeatherForecastPresenter.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import UIKit
import CoreLocation

class WeatherForecastPresenter: WeatherForecastViewOutput {
    var weatherService: WeatherInfoServiceProtocol = WeatherInfoService.shared
    var locationService: LocationServiceProtocol = LocationService.shared
    
    weak var view: WeatherForecastViewInput!
    var weathers: [[Weather]] = []
    
    init(view: WeatherForecastViewInput) {
        self.view = view
    }
    
    deinit {
        locationService.removeObserver(observer: self)
    }
    
    func viewIsReady() {
        locationService.register(observer: self)
        view.setupInitialState()
    }
    
    func getWeatherForecast(location: CLLocation) {
        view.startLoad()
        weatherService.weatherForecast(location: location) { [weak self] (weather, error) in
            if let weather = weather {
                self?.weathers = weather
                self?.view.updateTableView()
            }
            if let error = error {
                self?.view.show(error) { (alert) in
                    self?.getWeatherForecast(location: location)
                }
            }
            self?.view.finishLoad()
        }
    }
    
}

extension WeatherForecastPresenter: Observer {
    func notify(event: Event) {
        guard let event = event as? LocationEvent else {
            return
        }
        
        switch event {
        case .denied:
            self.view.startLoad()
            view.showAlert(title: "Geolocation Issue", message: "Please, enable geolocation.") { (action) in
                guard let settings: URL = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                UIApplication.shared.open(settings)
            }
            
        case .locationDidChanged(let location):
            getWeatherForecast(location: location)
        }
    
    }
    
    
}
