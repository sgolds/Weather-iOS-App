//
//  WeatherCell.swift
//  Weather Portfolio App
//
//  Created by Sten Golds on 1/25/17.
//  Copyright © 2017 Sten Golds. All rights reserved.
//

import UIKit

/**
 * @name WeatherCell
 * @desc class created to represent Forecast object in TableView
 */
class WeatherCell: UITableViewCell {
    
    //references to the WeatherCell created in storyboard
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    /**
     * @name configCell
     * @desc configures the WeatherCell with the data from the associated Forecast
     * @param Forecast forecast - Forecast of which this WeatherCell will represent
     * @return void
     */
    func configCell(forecast: Forecast) {
        
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
        weatherType.text = forecast.weatherType
        highTemp.text = "\(forecast.highTemp)"
        lowTemp.text = "\(forecast.lowTemp)"
        
    }
    
}
