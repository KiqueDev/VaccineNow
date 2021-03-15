//
//  DetailView.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 3/15/21.
//

import SwiftUI

struct DetailView: View {
    let station: Station
    var body: some View {
        Text("\(station.guid)")
        Text(station.name).font(.largeTitle)
    }
}
