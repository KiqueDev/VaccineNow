//
//  ListView.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/15/21.
//

import SwiftUI

struct Station: Identifiable {
    var id = UUID()
    var name: String
    var address: String
}

// Dymmy info for now
let stations = [
    Station(name: "Rite Aid Pharmacy", address: "6900 4th Ave, Brooklyn, NY 11209"),
    Station(name: "Wallgreen Pharmacy", address: "7821 3rd Ave, Brooklyn, NY 11209"),
    Station(name: "CVS Pharmacy", address: "6702 Fort Hamilton Pkwy, Brooklyn, NY 11219"),
    Station(name: "Walmart Pharmacy", address: "2413 Flatbush Ave, Brooklyn, NY 11234")
]

struct ListView: View {
    var body: some View {
        List(stations) { station in
            NavigationLink(destination: DetailView(station: station)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(station.name)").fontWeight(.bold)
                            .font(.title2)
                        Spacer()
                        Text("\(station.address)")
                    }
                }.navigationBarTitle(Text("Stations"))
            }
        }
    }
}
