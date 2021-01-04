//
//  ViewController.swift
//  WeatherBoard
//
//  Created by Baris Berkin Tasci on 3.01.2021.
//

import UIKit
import Alamofire

final class MainPageViewController: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var showWeatherButton: UIButton!
    
    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        cityNameTextField.text = ""
    }
    
    fileprivate func prepareUI() {
        prepareLayer(object: informationLabel as Any)
        prepareLayer(object: cityNameTextField as Any)
        prepareLayer(object: showWeatherButton as Any)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func prepareLayer(object: Any) {
        if let object = object as? UILabel {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UITextField {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        } else if let object = object as? UIButton {
            object.layer.cornerRadius = 5
            object.layer.masksToBounds = true
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func showWeatherButtonTouched(_ sender: Any) {
        let city = LocationModel()
        city.title = cityNameTextField.text ?? ""
        
        if city.title?.isEmpty ?? true {
            emptyCityTextfieldAlert()
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "WeatherBoardViewController") as! WeatherBoardViewController
            vc.city = city
            self.show(vc, sender: nil)
        }
    }
    
    // MARK: - ALERT METHODS
    
    fileprivate func emptyCityTextfieldAlert() {
        let emptyCityTextfieldAlert = UIAlertController(title: "", message: "City field can not be empty!", preferredStyle: .alert)
        self.present(emptyCityTextfieldAlert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            emptyCityTextfieldAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func invalidCityNameAlert() {
        let invalidCityNameAlert = UIAlertController(title: "", message: "Invalid city name. Please enter the city that you want to see its forecast", preferredStyle: .alert)
        self.present(invalidCityNameAlert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            invalidCityNameAlert.dismiss(animated: true, completion: nil)
        }
    }
}
