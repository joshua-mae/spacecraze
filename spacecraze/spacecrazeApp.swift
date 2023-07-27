//
//  spacecrazeApp.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

import SwiftUI

@main
struct spacecrazeApp: App {
    
    @StateObject private var vm = APODViewModel()
    @StateObject private var hvm = HistoricalViewModel()

    var body: some Scene {
        WindowGroup {
            TabView{
                
                APODView()
                    .environmentObject(vm)
                .tabItem{
                    Label("Home", systemImage: "house")
                }
                DiscoverView()
                    .environmentObject(hvm)
                .tabItem{
                    Label("Discover", systemImage: "magnifyingglass")
                }

            }
            .accentColor(.purple)
                   
        }
    }
}
