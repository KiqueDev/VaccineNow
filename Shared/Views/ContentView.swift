//
//  ContentView.swift
//  Shared
//
//  Created by Enrique on 12/7/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var zipcodeBindManager = ZipcodeBindManager(limit: 5)
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 5) {
                    Spacer()
                    // Label Title
                    Text("Find your nearest Vaccine Stations")
                        .fontWeight(.bold)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    HStack {
                        // Textfield zipcode
                        TextField("Enter zipcode", text: $zipcodeBindManager.text)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 150.0, height: 50)
                            .textFieldStyle(PlainTextFieldStyle())
                            .cornerRadius(16)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        // Find Button
                        let view = ListView(zipcode: zipcodeBindManager.text)
                        NavigationLink(destination: view) {
                            Text("Find")
                                .frame(minWidth: 100, maxWidth: 100, minHeight: 50, maxHeight: 50, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }.disabled(self.zipcodeBindManager.text.count == 0)
                    }.padding(.top, 15.0)
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
