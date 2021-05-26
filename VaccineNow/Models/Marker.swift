//
//  Marker.swift
//  VaccineNow
//
//  Created by Enrique on 5/26/21.
//

import SwiftUI
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}
