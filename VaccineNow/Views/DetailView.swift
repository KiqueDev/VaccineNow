//
//  DetailView.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/15/21.
//

import SwiftUI
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}

struct DetailView: View {
    let locationManager: LocationManager = LocationManager()
    let station: Station
    @State var marker: Marker = Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), tint: .red))
    @State var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.0, longitudeDelta: 0.0)
    )

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(station.name)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Text("\(station.address1) \(station.city), \(station.state) \(station.zip)")
                    .fontWeight(.bold)
                
                Text("\(station.phone)")
                    .fontWeight(.bold)
                
                station.in_stock ? Text("In Stock").fontWeight(.bold).foregroundColor(.green) : Text("Out of Stock").fontWeight(.bold).foregroundColor(.red)
            }.padding(15)
            
            Map(coordinateRegion: $region, showsUserLocation: false,
                annotationItems: [marker]) { marker in
                marker.location
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(){
                setLocations()
            }
        }
    }
    
    private func setLocations(){
        let address = "\(station.address1) \(station.city), \(station.state) \(station.zip)"
        print("ADDRESS: \(address)")
        locationManager.getStationLocation(address: address) { location in
            self.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long),
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
            self.marker = Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long), tint: .red))
        }
    }
}
