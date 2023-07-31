//
//  TabView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/30/23.
//

import SwiftUI

struct AllView: View {
    
    @StateObject private var vm = APODViewModel()
    @StateObject private var hvm = HistoricalViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            TabView {
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
                SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
            }

        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .tint(.indigo)
    }
}

struct AllView_Previews: PreviewProvider {
    static var previews: some View {
        AllView()
    }
}
