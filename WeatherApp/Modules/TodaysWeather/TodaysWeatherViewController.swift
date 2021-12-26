//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 28.09.2021.
//

import UIKit
import NVActivityIndicatorView

class TodaysWeatherViewController: UIViewController, TodaysWeatherViewInput {
 
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var humidityImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!

    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windSpeedImageView: UIImageView!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var pressureImageView: UIImageView!

    @IBOutlet weak var rainProbabilityLabel: UILabel!
    @IBOutlet weak var rainProbabilityImagView: UIImageView!
    
    @IBOutlet weak var clowdnessLabel: UILabel!
    @IBOutlet weak var clowdnessImageView: UIImageView!

    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    // TODO: rename
    @IBOutlet weak var workingUI: UIView!
    
    var output: TodaysWeatherViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = TodaysWeatherPresenter(view: self)
        output.viewIsReady()
    }
    
    func update(weather: Weather) {
        townLabel.text = weather.town
        temperatureLabel.text = weather.temperature.description + " C"
        
        humidityLabel.text = weather.humidity.description + " %"
        windSpeedLabel.text = weather.windSpeed.description + " m/c"
        rainProbabilityLabel.text = weather.rainProbability.description + " %"
        clowdnessLabel.text = weather.clowdness.description + " %"
        pressureLabel.text = weather.pressure.description + " mm"
        
        weatherImageView.load(url: weather.icon)
    }

    func startLoad() {
        activityIndicator.startAnimating()
        workingUI.isHidden = true
    }
    
    func finishLoad() {
        activityIndicator.stopAnimating()
        workingUI.isHidden = false
    }
    
}
