//
//  APIService.swift
//  VaccineNow
//
//  Created by Enrique on 5/26/21.
//

import UIKit

class APIService {
    let locationManager: LocationManager = LocationManager()
    private let baseURL = "https://api.us.castlighthealth.com/vaccine-finder/v1/provider-locations/search?medicationGuids=779bfe52-0dd8-4023-a183-457eb100fccc,a84fb9ed-deb4-461c-b785-e17c782ef88b,784db609-dc1f-45a5-bad6-8db02e79d44f"
    
    func loadData(zipcode: String, completion: @escaping (Response) -> Void) {
        // Conver zipcode to lat and long
        locationManager.convertZip(zip: zipcode) { location in
            if let location = location {
                guard let url = URL(string: self.baseURL + "&lat=\(location.lat)&long=\(location.long)&radius=10") else {
                    print("Invalid URL")
                    return
                }
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                            DispatchQueue.main.async {
                                completion(decodedResponse)
                            }
                        }
                    }
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }.resume()
            }
        }
    }
}
