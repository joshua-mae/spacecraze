//
//  DetailButtonView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/26/23.
//

import SwiftUI

struct DetailButtonView: View {

    
    var body: some View {
            ZStack{
            Text("Hello")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
    }
}

struct DetailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailButtonView()
    }
}
