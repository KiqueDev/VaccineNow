//
//  LoaderView.swift
//  VaccineNow
//
//  Created by Enrique on 5/26/21.
//

import SwiftUI

struct LoaderView: View {    
    var body: some View {
        ProgressView()
            .scaleEffect(2.0, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .black))
            .padding(30)
    }
}
