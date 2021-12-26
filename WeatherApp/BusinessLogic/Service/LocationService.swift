//
//  LocationService.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 14.11.2021.
//

import UIKit
import CoreLocation

protocol LocationServiceProtocol: Observable {
    var location: CLLocation? { get }
}

enum LocationEvent: Event {
    case locationDidChanged(CLLocation)
    case denied
}

class LocationService: NSObject, LocationServiceProtocol {
    // TODO: настроить
    private var locationManager: CLLocationManager = CLLocationManager()
    
    static let shared: LocationService = LocationService()
    
    var location: CLLocation? {
        return locationManager.location
    }
    
    var observers: [WeakBox<Observer>] = []
    
    override init() {
        super .init()
        locationManager.delegate = self
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        notifyObservers(LocationEvent.denied)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        notifyObservers(LocationEvent.locationDidChanged(location))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways , .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            notifyObservers(LocationEvent.denied)
        @unknown default:
            return
        }
    }
    
    func didRegister(observer: Observer) {
        guard let location = location else {
            return
        }
        observer.notify(event: LocationEvent.locationDidChanged(location))
    }
}

// TODO: открыл приложение - вышли - выкл гео - веернулсь - гео так  не вкл
// стринги
// вынос ссылок
