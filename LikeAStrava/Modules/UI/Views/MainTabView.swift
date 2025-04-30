//
//  TabView.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 15/04/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Start", systemImage: "play.circle")
                }

            HistoryView()
                .tabItem {
                    Label("Historia", systemImage: "clock.arrow.circlepath")
                }
        }
    }
}
