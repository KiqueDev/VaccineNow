//
//  LocationManager.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/19/21.
//

import Foundation
import Contacts
import CoreLocation

class LocationManager {
    static func convertZip(zip: String, completion: @escaping (Location?) -> Void) {
        let geocoder = CLGeocoder()
        let postalAddress = CNMutablePostalAddress()
        postalAddress.postalCode = zip
        geocoder.geocodePostalAddress(postalAddress, preferredLocale: Locale(identifier: "en_US")) { (placemarks, error) in
            if let error = error {
                print("ERROR geocodePostalAddress: \(error)")
                completion(nil)
            }
            if let placemark = placemarks?.first, let lat = placemark.location?.coordinate.latitude, let long = placemark.location?.coordinate.longitude  {
                let location = Location(lat: self.rounded(value: lat), long: self.rounded(value: long))
                completion(location)
            }
        }
    }
    
    private static func rounded(value: Double) -> Double {
        let divisor = pow(10.0, Double(2))
        return (value * divisor).rounded() / divisor
    }
}
