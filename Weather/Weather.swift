
import Foundation
import SwiftyJSON

class Weather {
    
    var location: String!
    var temp: Int!
    var desc: String!
    var wind: (speed:String, direction:String)!
    
    init(json: JSON) {
        location = json["name"].stringValue
        desc = json["weather"][0]["main"].stringValue
        temp = json["main"]["temp"].intValue
        wind = (json["wind"]["speed"].stringValue, json["wind"]["deg"].stringValue)
    }
    
}