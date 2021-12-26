//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UIView!
    
    func fill(with weather: Weather) {
        temperatureLabel.text = weather.temperature.description
    }
}
