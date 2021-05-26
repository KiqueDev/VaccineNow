//
//  Station.swift
//  VaccineNow
//
//  Created by Enrique on 5/26/21.
//

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
