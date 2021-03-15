//
//  MapView.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 12/11/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var locationManager = CLLocationManager()
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        generateAnnoLoc(mapView: mapView)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    func generateAnnoLoc(mapView: MKMapView) {
//        var num = 0
//        //First we declare While to repeat adding Annotation
//        while num != 15 {
//            num += 1
//            
//            //Add Annotation
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = generateRandomCoordinates(70, max: 150) //this will be the maximum and minimum distance of the annotation from the current Location (Meters)
//            annotation.title = "Annotation Title"
//            annotation.subtitle = "SubTitle"
//            mapView.addAnnotation(annotation)
//        }
    }
}
