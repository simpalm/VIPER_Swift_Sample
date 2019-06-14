//
//  WeatherProtocols.swift
//  VIPER
//
//  Created by Aman Sinha on 14/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//


import Foundation
import UIKit

protocol PresenterToViewProtocol: class {
    
    func showWeather(weather: WeatherDataModel)
    func showWeatherInFahrenhiet(celsius :Int)->Int
    func showError()
    
}

protocol InterectorToPresenterProtocol: class {
    
    func liveWeatherFetched(weather: WeatherDataModel)
    func liveWeatherFetchedFailed()
    
}

protocol PresentorToInterectorProtocol: class {
    
    var presenter: InterectorToPresenterProtocol? {get set}
    func fetchLiveWeather(city : String)
    func fetchLiveWeatherWithLatLong(lat : String,long :String)
    
}

protocol ViewToPresenterProtocol: class {
    
    var view: PresenterToViewProtocol? {get set}
    var interector: PresentorToInterectorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func updateView(withCity:String)
    func updateViewWithLatLong(lat:String,long:String)
}

protocol PresenterToRouterProtocol: class {
    
    static func createModule() -> UIViewController;
}
