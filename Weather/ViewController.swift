
import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var windStrengthLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: NSError?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if authStatus == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
    }
    
    @IBAction func update(sender: AnyObject) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherForLocation(location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather", parameters:
            ["lat": lat, "lon": lon, "units": "metric", "APPID": "bc620920461d6ff26e97805183bf8fdd"]
            )
            .responseJSON { request, response, json, error in
                if error == nil {
                    var json = JSON(json!)
                    let weather = Weather(json: json)
                    self.updateView(weather)
                }
        }
    }
    
    func updateView(weather: Weather) {
        locationLabel.text = weather.location
        descLabel.text = weather.desc
        tempLabel.text = "\(weather.temp)"
        windStrengthLabel.text = weather.wind.speed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("didFailWithError \(error)")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let newLocation = locations.last as! CLLocation
        getWeatherForLocation(newLocation)
    }
    
}
