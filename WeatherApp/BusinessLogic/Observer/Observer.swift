//
//  Observer.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 19.12.2021.
//

import Foundation

protocol Observer: AnyObject {
    func notify(event: Event)
}
