//
//  CircleImage.swift
//  Landmarks
//
//  Created by Kocfinans on 25.11.2020.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("koccim")
            .frame(width: 300.0, height: 300.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 25)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
