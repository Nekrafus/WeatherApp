//
//  ErrorAlerts.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 28.11.2021.
//

import UIKit

protocol UIViewInput where Self: UIViewController {
    func show(_ error: Error, handler: ((UIAlertAction) -> Void)?)
    func showAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?)
}


extension UIViewInput {
    
    func show(_ error: Error, handler: ((UIAlertAction) -> Void)?) {
        showAlert(title: "Error", message: error.localizedDescription, handler: handler)
    }
    
    func showAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: handler)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

}
