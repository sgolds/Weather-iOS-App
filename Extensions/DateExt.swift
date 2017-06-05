//
//  DateExt.swift
//  Weather Portfolio App
//
//  Created by Sten Golds on 1/25/17.
//  Copyright © 2017 Sten Golds. All rights reserved.
//

import Foundation

/**
 * @name Date
 * @desc extension of Date class to include method that returns the Date's corresponding day of the week
 */
extension Date {
    
    /**
     * @name dayOfTheWeek
     * @desc returns day of week for which the Date falls on
     * @return String - Day of week
     */
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}
