//
//  ListView.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/15/21.
//

import SwiftUI

struct ListView: View {
    @State private var stations: [Station] = []
    @State private var hideLoader = false

    let zipcode: String
    let apiService = APIService()

    var body: some View {
        LoaderView().isHidden(hideLoader, remove: hideLoader)
        List(stations, id: \.guid) { station in
            NavigationLink(destination: DetailView(station: station)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(station.name).fontWeight(.bold)
                            .font(.title2)
                        Text("\(station.address1)")
                        Text("\(station.city), \(station.state) \(station.zip)")
                    }
                }.navigationBarTitle(Text("Stations"))
            }
        }.onAppear {
            if self.stations.isEmpty {
                apiService.loadData(zipcode: zipcode) { response in
                    self.hideLoader = true
                    self.stations = response.providers
                }
            }
        }
    }
}
