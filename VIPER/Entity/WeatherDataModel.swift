////
////  WeatherDataModel.swift
////  VIPER
////
////  Created by Aman Sinha on 14/05/19.
////  Copyright © 2019 simplam. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SwiftyJSON
//class WeatherDataModel:Codable {
//
//    //Declare your model variables here...
//    var temperature : Int = 0
//    var condition : Int = 0
//    var city : String = ""
//    var weatherIconName : String = ""
//
//    init(json: JSON) {
//
//        let tempResult = json["main"]["temp"].doubleValue
//
//        temperature = Int(tempResult - 273.15)
//
//        city = json["name"].stringValue
//
//        condition = json["weather"][0]["id"].intValue
//
//        weatherIconName = updateWeatherIcon(condition: condition)
//
//    }
//
//    func updateWeatherIcon(condition: Int) -> String {
//
//        switch (condition) {
//
//        case 0...300 :
//            return "tstorm1"
//
//        case 301...500 :
//            return "light_rain"
//
//        case 501...600 :
//            return "shower3"
//
//        case 601...700 :
//            return "snow4"
//
//        case 701...771 :
//            return "fog"
//
//        case 772...799 :
//            return "tstorm3"
//
//        case 800 :
//            return "sunny"
//
//        case 801...804 :
//            return "cloudy2"
//
//        case 900...903, 905...1000  :
//            return "tstorm3"
//
//        case 903 :
//            return "snow5"
//
//        case 904 :
//            return "sunny"
//
//        default :
//            return "dunno"
//        }
//    }
//}
//========================================================================



//  WeatherDataModel.swift
//  VIPER
//
//  Created by Aman Sinha on 14/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import Foundation
import UIKit
//import SwiftyJSON
class WeatherDataModel:Codable {
    
    //Declare your model variables here...
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    init(jsonDict: [String: Any]) {
        guard let main = jsonDict["main"] as? [String: Any] else{return}
       // let main = jsonDict["main"] as! [String: Any]
        
        guard let tempResult: Double = main["temp"] as? Double else{return}
        
        temperature = Int(tempResult - 273.15)
        
        city = jsonDict["name"] as! String
        
        guard let weather = jsonDict["weather"] as? [Any] else{return}
        
        guard let firstWeatherDict = weather[0] as? [String: Any] else{return}
        
        condition = firstWeatherDict["id"] as! Int
        
        weatherIconName = updateWeatherIcon(condition: condition)
        
    }
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
    }
}
