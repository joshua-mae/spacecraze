//
//  AcknowledgementView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/29/23.
//

import SwiftUI

struct AcknowledgementView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Section(header: Text("Overview").font(.title).fontWeight(.bold).foregroundColor(.indigo)) {
                    Text("This is a section dedicating acknowledgement to where I get the sources for this information and covering a little more on my journey to creating this app.")
                }
                Section(header: Text("Sources").font(.title).fontWeight(.bold).foregroundColor(.indigo)) {
                    Text("The main source was the NASA APOD API which has been used in thousands of projects, but I know that I can create something clean, without ads, native, and unique for iOS users to use.  Moreover, I got the inspiration for this because the NASA API docs were easy to use and the other apps present in the app store have a 2015 esque UI that I wanted to modernize.  So, SpaceCraze was born with hopes to be pubished to the app store.")
                }
                Section(header: Text("Closing").font(.title).fontWeight(.bold).foregroundColor(.indigo)) {
                    Text("I want to thank everyone in my life for helping me be the best version I can be.  I hope that this is not the last app that I publish")
                    
                }
            }
            .padding()
            .foregroundColor(.primary)
        }
        .background(.ultraThickMaterial)
        

    }
}

struct AcknowledgementView_Previews: PreviewProvider {
    static var previews: some View {
        AcknowledgementView()
    }
}
