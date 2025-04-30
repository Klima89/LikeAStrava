//
//  MainView.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 11/04/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dystans: \(String(format: "%.2f", viewModel.distance / 1000)) km")
            Text("Czas: \(viewModel.elapsedTime, specifier: "%.2f") s")
            
            Button(viewModel.isTracking ? "Stop" : "Start") {
                viewModel.isTracking ? viewModel.stopWorkout(): viewModel.startWorkout()
            }
            .padding()
            .background(viewModel.isTracking ? Color.red : Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
    }
}


