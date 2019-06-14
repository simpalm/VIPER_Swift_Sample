//
//  WeatherPresenter.swift
//  VIPER
//
//  Created by Aman Sinha on 14/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import Foundation

class WeatherPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var interector: PresentorToInterectorProtocol?
    var router: PresenterToRouterProtocol?
    
    func updateView(withCity:String) {
        
        interector?.fetchLiveWeather(city:withCity)
        
    }
    
    func updateViewWithLatLong(lat:String,long:String){
        
        interector?.fetchLiveWeatherWithLatLong(lat:lat,long:long)
    }
}
extension WeatherPresenter: InterectorToPresenterProtocol {
    func liveWeatherFetched(weather: WeatherDataModel) {
        view?.showWeather(weather: weather)
    }
    
    func liveWeatherFetchedFailed() {
        view?.showError()
    }
}
