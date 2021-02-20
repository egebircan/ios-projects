//
//  UserData.swift
//  Landmarks
//
//  Created by Kocfinans on 26.11.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

import Combine

final class UserData: ObservableObject  {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
