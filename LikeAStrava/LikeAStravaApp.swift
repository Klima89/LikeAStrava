//
//  LikeAStravaApp.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 29/03/2025.
//

import SwiftUI

@main
struct LikeAStravaApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .tabItem { Label("Start", systemImage: "play.circle")}
            HistoryView()
                .tabItem { Label("Historia", systemImage: "clock") }
        }
    }
}
