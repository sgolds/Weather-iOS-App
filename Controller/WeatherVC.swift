//
//  WeatherVC.swift
//  Weather Portfolio App
//
//  Created by Sten Golds on 1/23/17.
//  Copyright © 2017 Sten Golds. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //references to the WeatherVC created in storyboard
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currWeatherImage: UIImageView!
    @IBOutlet weak var currWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //CLLocationManager needed for CoreLocation functionality
    let locationManager = CLLocationManager()
    
    //variable used to store user's current location
    var currLocation: CLLocation!
    
    //variables used to store retrieved current weather and forecasts
    var currWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        //tableView setup
        tableView.delegate = self
        tableView.dataSource = self
        
        //initialize current weather variable
        currWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    // MARK: Location

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //call function to evaluate location auth status when auth status is changed
        locationAuthStatus()
    }
    
    /**
     * @name locationAuthStatus
     * @desc checks if the user is authorized, if the user is gets user location, updates API URLs, and downloads weather data for the location, if the user is not authorized, rechecks
     * @return void
     */
    func locationAuthStatus() {
        
        //if statement checks if user has enabled location services
        if CLLocationManager.locationServicesEnabled() {
            
            //checks that user location can be grabbed
            if let locValue:CLLocationCoordinate2D = locationManager.location?.coordinate {
                
                //sets Location Singleton location to user location
                Location.sharedInstance.latitude = locValue.latitude
                Location.sharedInstance.longitude = locValue.longitude
                
                //updates API URLs
                Location.sharedInstance.updateWeather()
                
                //downloads location weather data, and updates the UI
                currWeather.downloadWeatherDetails {
                    self.downloadForecastData {
                        self.updateMainUI()
                    }
                }
            }
            
        } else {
            
            //recalls auth status function, as weather app will not work unless location is authorized
            locationAuthStatus()
        }
    }
    
    
    // MARK: - Forecast and UI Helper Methods
    
    /**
     * @name downloadForecastData
     * @desc grabs forecast data from API, and updates forecast array with retrieved data
     * @param DownloadComplete completed - for ending the function
     * @return void
     */
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        //Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            //cast result as dictionary
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                //get forecast list from resulting dictionary
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    //clear old forecasts
                    self.forecasts.removeAll()
                    
                    //initialize forecasts for retrieved data, and add to forecasts array
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    
                    //remove first forecast, as that is the current weather
                    self.forecasts.remove(at: 0)
                    
                    //refresh tableview with new data
                    self.tableView.reloadData()
                }
            }
            
            //exit function
            completed()
        }
    }
    
    /**
     * @name updateMainUI
     * @desc updates the user interface to reflect the data for the user's current weather at location
     * @return void
     */
    func updateMainUI() {
        dateLabel.text = currWeather.date
        currentTempLabel.text = "\(currWeather.currTemp)"
        currWeatherTypeLabel.text = currWeather.weatherType
        locationLabel.text = currWeather.cityName
        currWeatherImage.image = UIImage(named: currWeather.weatherType)
    }

}
