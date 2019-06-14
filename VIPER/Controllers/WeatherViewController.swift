//
//  WeatherViewController.swift
//  VIPER
//
//  Created by Aman Sinha on 14/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import CustomDialogSimpalm

class WeatherViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var faren: UISwitch!
    var presenter: ViewToPresenterProtocol?
    
    @IBAction func clickNext(_ sender: Any) {
        self.performSegue(withIdentifier: "changeCityName", sender: nil)
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if sender.isOn {
            temperatureLabel.text = "\(weatherData.temperature)℃"
        }
        else{
            // CALL: calling view model.
            // temperatureLabel.text = "\(weatherData.temperature)°"
            
            temperatureLabel.text = "\(self.showWeatherInFahrenhiet(celsius: weatherData.temperature))℉"
            
        }
    }
    //TODO: Declare instance variables here
    let locationManager2 = CLLocationManager()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    var weatherData : WeatherDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here.
        locationManager2.delegate = self
        locationManager2.desiredAccuracy = kCLLocationAccuracyBest
        locationManager2.requestWhenInUseAuthorization()
        locationManager2.startUpdatingLocation()
       
        
    }
    
    //MARK: - UI Updates
    /*-------------------------------------------------------------*/

    func updateUIWithWeatherData(weather : WeatherDataModel!) {
        
        weatherData = weather
        cityLabel.text = weather.city
        temperatureLabel.text = "\(weather.temperature)°"
        weatherIcon.image = UIImage(named: weather.weatherIconName)
        
    }
    
    //MARK: - Location Manager Delegate Methods
    /*-------------------------------------------------------------*/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager2.stopUpdatingLocation()
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            presenter?.updateViewWithLatLong(lat: "\(location.coordinate.latitude)", long: "\(location.coordinate.longitude)")
           
            
        }
    }
    
    // didFailWithError method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
       // cityLabel.text = "Location Unavailable"
        presenter?.updateView(withCity: "Indore")
        
    }
    
    // PrepareForSegue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! CityViewController
            destinationVC.delegate = self
            
        }
    }
}

extension WeatherViewController: CityDelegate {
    
    func userEnteredNewCity(city: String) {
        
        presenter?.updateView(withCity: city)
    
    }
}


extension WeatherViewController: PresenterToViewProtocol {

    func showWeather(weather: WeatherDataModel) {
        
        weatherData = weather
        
        cityLabel.text = weather.city
        
        if self.faren.isOn{
            
            self.temperatureLabel.text = "\(weather.temperature)℃"
            
        }
        else{
            
            temperatureLabel.text = "\(self.showWeatherInFahrenhiet(celsius: weather.temperature))℉"
            
        }
        
        weatherIcon.image = UIImage(named: weather.weatherIconName)
        
    }
    
    func showWeatherInFahrenhiet(celsius :Int)->Int{
        
        return Int((celsius*9/5)+32)
        
    }
    
    func showError() {
        
        let alert = ASDialogView()
        
        alert.getAlertWith(title: "City not found!", message: "Do you want to find weather again.", withCancel: true, onView: self.view) { isOk in
            if isOk == true{
                
                self.performSegue(withIdentifier: "changeCityName", sender: nil)
                
            }
        }
    }
}
