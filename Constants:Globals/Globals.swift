//
//  Globals.swift
//  Weather Portfolio App
//
//  Created by Sten Golds on 1/26/17.
//  Copyright © 2017 Sten Golds. All rights reserved.
//

//constant for weather API base URL
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"

//constants for URL parameter formats
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="

//declaration constant for escaping download complete type
typealias DownloadComplete = () -> ()

//globals for weather URL and forecast URL to retrieve data
var CURRENT_WEATHER_URL = ""
var FORECAST_URL = ""
