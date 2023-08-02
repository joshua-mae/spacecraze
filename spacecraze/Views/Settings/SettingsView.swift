//
//  SettingsView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/29/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            List{
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                Section("Other") {
                    NavigationLink(destination: AcknowledgementView()) {
                        Text("Acknowledgements")
                    }
                    HStack {
                        Text("Version Number")
                        Text(Bundle.main.releaseVersionNumber ?? "")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack {
                        Text("Build Number")
                        Text(Bundle.main.buildVersionNumber ?? "")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.ultraThickMaterial)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)

    }
        
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
