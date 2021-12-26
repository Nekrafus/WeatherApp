//
//  Observable.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 19.12.2021.
//

import Foundation

protocol Observable {
    var observers: [WeakBox<Observer>] { get set }
    
    mutating func removeObserver(observer: Observer)
    mutating func register(observer: Observer)
    
    func didRegister(observer: Observer)
    func notifyObservers(_ event: Event)
}


extension Observable {
    mutating func removeObserver(observer: Observer) {
        observers.removeAll(where: {(weakBox) -> Bool in
            return weakBox.object === observer
        })
    }

    mutating func register(observer: Observer) {
        let isContains = observers.contains(where: { (weakBox) -> Bool in
            return weakBox.object === observer
        })
        guard !isContains else {
            return
        }
        let object = WeakBox(object: observer)
        observers.append(object)
        didRegister(observer: observer)
    }
    
    func notifyObservers(_ event: Event) {
        observers.forEach { (box) in
            box.object?.notify(event: event)
        }
    }
    
    func didRegister(observer: Observer) {}
}
