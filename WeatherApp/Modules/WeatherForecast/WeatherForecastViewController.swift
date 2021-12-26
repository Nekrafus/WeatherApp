//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Vladimir Pulkhrov on 03.10.2021.
//

import UIKit
import NVActivityIndicatorView

class WeatherForecastViewController: UIViewController, WeatherForecastViewInput {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    var output: WeatherForecastViewOutput!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = WeatherForecastPresenter(view: self)
        output.viewIsReady()
    }
    
    // MARK: Input
    func setupInitialState() {
        tableView.dataSource = self
        tableView.rowHeight = 56
    }

    func updateTableView() {
        tableView.reloadData()
    }
    
    func startLoad() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func finishLoad() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
}

extension WeatherForecastViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.weathers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let date = output.weathers[section].first?.date else {
            return nil
        }
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.weathers[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as? WeatherCell else {
            return WeatherCell()
        }
        
        let weather = output.weathers[indexPath.section][indexPath.row]
        cell.fill(with: weather)
        return cell
    }
}
