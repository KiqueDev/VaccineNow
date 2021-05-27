//
//  DetailView.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/15/21.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let locationManager: LocationManager = LocationManager()
    let station: Station
    @State var marker: Marker = Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), tint: .black))
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
            .onAppear(perform: setLocations)
        }
        .toolbar {
            // BUG on swiftui where the back button dissapears
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: actionSheet) {
                    Image(systemName: "square.and.arrow.up")
                }

                Button(action: phoneCall) {
                    Image(systemName: "phone")
                }
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
            self.marker = Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long), tint: .black))
        }
    }
    
    private func actionSheet() {
        let place = station.name
        let address = "\(station.address1) \(station.city), \(station.state) \(station.zip)"
        let phone = station.phone
        let activityVC = UIActivityViewController(activityItems: [place, address, phone], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    private func phoneCall() {
        let telephone = "tel://"
        let formattedString = telephone + station.phone
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }
}
