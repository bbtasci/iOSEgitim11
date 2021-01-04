//
//  WeatherBoardVC.swift
//  WeatherBoard
//
//  Created by Baris Berkin Tasci on 3.01.2021.
//

import UIKit
import Alamofire

final class WeatherBoardViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var city = LocationModel()
    var weather = ConsolidatedWeatherModel()
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "WeatherBoard"
        
        cityLabel.text = city.title?.uppercased()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - SERVICE CALL
    
    fileprivate func getData() {
        
        AF.request("https://www.metaweather.com/api/location/search/?query=\(city.title ?? "")").responseJSON { response in
            if let data = response.data {
                let currentSearchedCity = try! JSONDecoder().decode([LocationModel].self, from: data)
                self.city.woeid = currentSearchedCity[0].woeid
                
                AF.request("https://www.metaweather.com/api/location/\(String(self.city.woeid ?? 0))/").responseJSON { response in
                    if let weatherData = response.data {
                        let weatherInfo = try! JSONDecoder().decode(WeatherModel.self, from: weatherData)
                        self.weatherLabel.text = "\(String(Int((weatherInfo.consolidated_weather?[0].the_temp) ?? 0)))° C"
                    }
                }
            } else {
                self.invalidCityNameAlert()
            }
        }
    }
    
    // MARK: - ALERT METHOD
    
    fileprivate func invalidCityNameAlert() {
        let invalidCityNameAlert = UIAlertController.init(title: "ERROR", message: "Invalid city name. Please enter correct name of the city.", preferredStyle: .alert)
        self.present(invalidCityNameAlert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            invalidCityNameAlert.dismiss(animated: true, completion: nil)
        }
    }
}
