//
//  LocationManager.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/19/21.
//

import Foundation
import Contacts
import CoreLocation
import MapKit

class LocationManager {
    let geocoder = CLGeocoder()
    let postalAddress = CNMutablePostalAddress()
    
    func convertZip(zip: String, completion: @escaping (Location?) -> Void) {
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
    
    func getStationLocation(address: String, completion: @escaping (Location) -> Void) {
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let locationMark = placemark.location {
                let location = Location(lat: locationMark.coordinate.latitude, long: locationMark.coordinate.longitude)
                completion(location)
            }
        }
    }
    
    private func rounded(value: Double) -> Double {
        let divisor = pow(10.0, Double(2))
        return (value * divisor).rounded() / divisor
    }
}
