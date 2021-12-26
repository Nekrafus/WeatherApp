//
//  TodaysWeathePresenter.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import UIKit
import CoreLocation

class TodaysWeatherPresenter: NSObject, TodaysWeatherViewOutput {
    weak var view: TodaysWeatherViewInput!
    var weatherService: WeatherInfoServiceProtocol = WeatherInfoService.shared
    var locationService: LocationServiceProtocol = LocationService.shared
    
    init(view: TodaysWeatherViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        locationService.register(observer: self)
    }

    func requestWeather(location: CLLocation) {
        view.startLoad()
        weatherService.getTodaysWeather(location: location) { [weak self] (weather, error) in
            guard let self = self else { return }
            
            if let weather = weather {
                self.view.update(weather: weather)
            }
            if let error = error {
                self.view.startLoad()
                self.view.show(error) { (_) in
                    if let location = self.locationService.location {
                        self.requestWeather(location: location)
                    }
                }
            }
            self.view.finishLoad()
        }
    }
    
}

extension TodaysWeatherPresenter: Observer {
    
    func notify(event: Event) {
        guard let event = event as? LocationEvent else {
            return
        }
        
        switch event {
        case .denied:
            self.view.startLoad()
            view.showAlert(title: "Geo", message: "geo disabled") { (action) in
                let settings: URL = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(settings)
            }
        case .locationDidChanged(let location):
            requestWeather(location: location)
        }
    }
    
}
