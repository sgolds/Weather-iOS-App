//
//  CurrentWeather.swift
//  Weather Portfolio App
//
//  Created by Sten Golds on 1/24/17.
//  Copyright © 2017 Sten Golds. All rights reserved.
//

import UIKit
import Alamofire

/**
 * @name CurrentWeather
 * @desc class created for CurrentWeather objects
 */
class CurrentWeather {
    
    //private CurrentWeather object properties
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currTemp: Double!
    
    //public CurrentWeather object property getters, so code outside this class code cannot change the properties
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currTemp: Double {
        if _currTemp == nil {
            _currTemp = 0.0
        }
        
        return _currTemp
    }
    
    /**
     * @name downloadWeatherDetails
     * @desc grabs current weather data from API,as well as sets the associated variables with the data
     * @param DownloadComplete completed - for ending the function
     * @return void
     */
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        //Download Current Weather Data
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
            //save retrieved result
            let result = response.result
            
            //get dictionary of values from result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                //get city from result, and save it to _cityName variable
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                //get weather array of dictionaries from result
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    //get weather type from first item in weather array, and save it to _weatherType variable
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                    
                }
                
                //get main data dictionary from result
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    //get temperature in Kelvin from result, convert from Kelvin to Fahrenheit, and save converted temperature to _currTemp variable
                    if let currentTemperature = main["temp"] as? Double {
                        
                        self._currTemp = self.kelvToFahr(initial: currentTemperature)
                    }
                }
            }
            
            //exit function
            completed()
        }
    }
    
    /**
     * @name kelvToFahr
     * @desc converts a value representing a temperature in Kelvin to the Fahrenheit equivalent
     * @param Double initial - initial Kelvin temperature
     * @return Double - Fahrenheit temperature
     */
    func kelvToFahr(initial: Double) -> Double {
        let kelvinToFahrenheitPreDivision = (initial * (9/5) - 459.67)
        let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDivision/10))
        
        return kelvinToFahrenheit
    }
}
