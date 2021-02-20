//
//  ContentView.swift
//  Landmarks
//
//  Created by Kocfinans on 25.11.2020.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            MapView()
//                .frame(height: 300)
//                .edgesIgnoringSafeArea(.top)
//
//            CircleImage()
//                .offset(y: -130)
//                .padding(.bottom, -130)
//
//            VStack(alignment: .leading) {
//                Text("Koçfinans")
//                    .font(.title)
//                HStack {
//                    Text("Ünalan, İstanbul")
//                        .font(.subheadline)
//                    Spacer()
//                    Text("Türkiye")
//                        .font(.subheadline)
//                }
//            }
//            .padding()
//            Spacer()
//        }
//    }
//}

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack {
                Text("Koçfinans")
                    .font(.title)
                HStack {
                    Text("Ünalan")
                    Text("İstanbul")
                }
            }
        }
    }
}

//struct ContentView: View {
//    @State private var name = ""
//
//    var body: some View {
//        Form {
//            TextField("Enter your name", text: $name)
//            Text("Your name is \(name)")
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
