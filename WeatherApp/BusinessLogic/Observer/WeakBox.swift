//
//  WeakBox.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 19.12.2021.
//

import Foundation

class WeakBox<Element> {
    weak private var _object: AnyObject?
    
    var object: Element? {
        return _object as? Element
    }
    
    init(object: Element) {
        self._object = object as AnyObject
    }
}
