//
//  Weather.swift
//  Weather
//
//  Created by Kyle Goslan on 30/07/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather {
    
    var location: String!
    var temp: Int!
    var desc: String!
    var wind: (speed:String, direction:String)!
    
    init(json: JSON) {
        println(json)
        location = json["name"].stringValue
        desc = json["weather"][0]["main"].stringValue
        temp = json["main"]["temp"].intValue
        wind = (json["wind"]["speed"].stringValue, json["wind"]["deg"].stringValue)
    }
    
}