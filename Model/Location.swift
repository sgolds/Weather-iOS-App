//
//  Location.swift
//  Weather Portfolio App
//
//  Created by Sten Golds on 1/25/17.
//  Copyright © 2017 Sten Golds. All rights reserved.
//

import CoreLocation

/**
 * @name Location
 * @desc class created for Location objects
 */
class Location {
    
    //singleton Location
    static var sharedInstance = Location()
    
    //private init function to ensure Singleton
    private init() {}
    
    //variables for latitude and longitude
    var latitude: Double!
    var longitude: Double!
    
    /**
     * @name updateWeather
     * @desc updates global weather URLs for retrieving data to reflect current position
     * @return nil
     */
    func updateWeather() {
        
        CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude!)&lon=\(longitude!)&appid=" + API_KEY
        FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitude!)&lon=\(longitude!)&cnt=10&mode=json&appid=" + API_KEY
        
    }
}
