//
//  WeatherInteracter.swift
//  VIPER
//
//  Created by Aman Sinha on 14/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//


import Foundation


class WeatherInterecter: PresentorToInterectorProtocol{
    
    var presenter: InterectorToPresenterProtocol?;
    
    func fetchLiveWeather(city :String) {
        
        //Create a session that we can use for this request
        let session = URLSession(configuration: .default)
        
        //Constants
        let url = Constants.URL
        let apiKey = Constants.NEWS_API_KEY
        
        //Storing request parameters
        var items = [URLQueryItem]()
        var urlComponents = URLComponents(string: url)
        let param = ["q":city,"appid":apiKey]
        
        for (key,value) in param {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents?.queryItems = items
        
        //Making the data fetch request using URLSession
        let request =  URLRequest(url: (urlComponents?.url)!)
        
        let datatask = session.dataTask(with: request, completionHandler: {data, response, error in
            
            //Check for the receipt of data and handle errors if data is not received
            if error == nil {
                
                //Store fetched Json data in a dictionary format
                let receivedData = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                //Transfer the fetched data to the weather data model
                let weather: WeatherDataModel = WeatherDataModel(jsonDict: receivedData)
                
                //Present weather data if a city is entered or error if not
                if weather.city != "" {
                    self.presenter?.liveWeatherFetched(weather: weather)
                }else{
                    self.presenter?.liveWeatherFetchedFailed()
                    print("No city entered")
                }
                
            } else {
                self.presenter?.liveWeatherFetchedFailed()
                print(error!)
            }
        })
        datatask.resume()
        
    }
    
    func fetchLiveWeatherWithLatLong(lat : String,long :String){
        
        //Create a session that we can use for this request
        let session = URLSession(configuration: .default)
        
        //Constants
        let url = Constants.URL
        let apiKey = Constants.NEWS_API_KEY
        
        //Storing request parameters
        var items = [URLQueryItem]()
        var urlComponents = URLComponents(string: url)
        let param = ["lat": lat, "lon": long, "appid":apiKey]
        
        for (key,value) in param {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents?.queryItems = items
        
        //Making the data fetch request using URLSession
        let request =  URLRequest(url: (urlComponents?.url)!)
        
        let datatask = session.dataTask(with: request, completionHandler: {data, response, error in
            
            //Check for the receipt of data and handle errors if data is not received
            if error == nil {
                
                //Store fetched Json data in a dictionary format
                let receivedData = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                //Transfer the fetched data to the weather data model
                let weather: WeatherDataModel = WeatherDataModel(jsonDict: receivedData)
                
                //Present weather data if a city is entered or error if not
                if weather.city != "" {
                    self.presenter?.liveWeatherFetched(weather: weather)
                }else{
                    self.presenter?.liveWeatherFetchedFailed()
                    print("No city entered")
                }
                
            } else {
                self.presenter?.liveWeatherFetchedFailed()
                print(error!)
            }
        })
        datatask.resume()
        
    }
}

