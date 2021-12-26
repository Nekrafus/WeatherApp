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
    @IBOutlet weak var timeLabel: UILabel!
    
    private let dateFormatter: DateFormatter = {
        let df: DateFormatter = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("HH:mm")
        return df
    }()
    
    func fill(with weather: Weather) {
        temperatureLabel.text = weather.temperature.description + " C"
        timeLabel.text = dateFormatter.string(from: weather.date)
        weatherImageView.load(url: weather.icon)
    }
    
}
