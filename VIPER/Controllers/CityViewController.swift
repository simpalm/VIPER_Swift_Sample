//
//  CityViewController.swift
//  VIPER
//
//  Created by Aman Sinha on 14/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import UIKit
import CustomDialogSimpalm

//Write the protocol declaration here:

protocol CityDelegate {
    
    func userEnteredNewCity(city: String)
    
}

class CityViewController: UIViewController {
    
    var delegate : CityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    //Getting Weather.
    /*-------------------------------------------------------------*/
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        let cityName:String = changeCityTextField.text!
        
        if cityName.count>0{
            
            delegate?.userEnteredNewCity(city: cityName)
            
            self.navigationController?.popViewController(animated: true)
            
        }
        else{
            
            let alert = ASDialogView()
            alert.getAlertWith(title: "Alert!", message: "Please enter city name.", onView: self.view) {
                self.changeCityTextField.becomeFirstResponder()
            }
        }
    }
    //Back Button.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
       self.navigationController?.popViewController(animated: true)
    }
    
}
