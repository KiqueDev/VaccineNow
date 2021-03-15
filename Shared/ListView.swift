//
//  ListView.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/15/21.
//

import SwiftUI
import CoreLocation
import Contacts

struct Station: Codable {
    var guid: String
    var name: String
    var address1: String
    var city: String
    var state: String
    var zip: String
    var phone: String
    var in_stock: Bool
}

struct Response: Codable {
    var providers: [Station]
}

struct Location {
    var lat: Double
    var long: Double
}

struct ListView: View {
    @State private var stations = [Station]()
    let zipcode: String

    var body: some View {
        List(stations, id: \.guid) { station in
            NavigationLink(destination: DetailView(station: station)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(station.name).fontWeight(.bold)
                            .font(.title2)
                        Spacer()
                        Text("\(station.address1)")
                        Text("\(station.city) \(station.state) \(station.zip)")

                    }
                }.navigationBarTitle(Text("Stations"))
            }
        }.onAppear(perform: loadData)
    }
    
    private func rounded(value: Double) -> Double {
        let divisor = pow(10.0, Double(2))
        return (value * divisor).rounded() / divisor
    }
    
    private func convertZip(zip: String, completion: @escaping (Location?) -> Void) {
        let geocoder = CLGeocoder()
        let postalAddress = CNMutablePostalAddress()
        postalAddress.postalCode = zip
        geocoder.geocodePostalAddress(postalAddress, preferredLocale: Locale(identifier: "en_US")) { (placemarks, error) in
            if let error = error {
                print("ERROR geocodePostalAddress: \(error)")
                completion(nil)
            }
            if let placemark = placemarks?.first, let lat = placemark.location?.coordinate.latitude, let long = placemark.location?.coordinate.longitude  {
                let location = Location(lat: rounded(value: lat), long: rounded(value: long))
                completion(location)
            }
        }
    }
    
    private func loadData() {
        // Conver zipcode to lat and long
        convertZip(zip: zipcode) { location in
            if let location = location {
                guard let url = URL(string: "https://api.us.castlighthealth.com/vaccine-finder/v1/provider-locations/search?medicationGuids=779bfe52-0dd8-4023-a183-457eb100fccc,a84fb9ed-deb4-461c-b785-e17c782ef88b,784db609-dc1f-45a5-bad6-8db02e79d44f&lat=\(location.lat)&long=\(location.long)&radius=10") else {
                    print("Invalid URL")
                    return
                }
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                            DispatchQueue.main.async {
                                self.stations = decodedResponse.providers
                            }
                            return
                        }
                    }
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }.resume()
            }
        }
    }
}
