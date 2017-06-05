//
//  Forecast.swift
//  Weather Portfolio App
//
//  Created by Sten Golds on 1/24/17.
//  Copyright © 2017 Sten Golds. All rights reserved.
//

import UIKit
import Alamofire

/**
 * @name Forecast
 * @desc class created for Forecast objects
 */
class Forecast {
    
    //private Forecast object properties
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    //public Forecast object property getters, so code outside this class code cannot change the properties
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    //initialize the Forecast object using Dictionary<String, AnyObject>
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        //if statement below performs the following:
        // 1. check if dictionary has a value of the correct type for temperature
        // 2. if dictionary has a value for temperature, checks if the temp dictionary has a min and/or max value
        // 3. if temp dictionary has a min and/or max value, converts these values from Kelvin to Fahrenheit, and sets respective _lowTemp/_highTemp variable
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                
//                let kelvinToFarenheitPreDivision = (min * (9/5) - 459.67)
//                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                let fahrTemp = kelvToFahr(initial: min)
                
                self._lowTemp = "\(fahrTemp)"
            }
            
            if let max = temp["max"] as? Double {
                
//                let kelvinToFarenheitPreDivision = (max * (9/5) - 459.67)
//                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                let fahrTemp = kelvToFahr(initial: max)
                
                self._highTemp = "\(fahrTemp)"
                
            }
            
        }
        
        //if statement below performs the following:
        // 1. check if dictionary has a value of the correct type for weather
        // 2. if first dictionary in array has a value for main, if so, sets _weatherType to value
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        //if statement below performs the following:
        // 1. check if dictionary has a value of the correct type for date
        // 2. if so, convert date to day of the week corresponding and set _date to that
        if let date = weatherDict["dt"] as? Double {
        
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
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
