//
//  ConstellationView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/28/23.
//

import SwiftUI

struct ConstellationView: View {
    let imageUrl: String = "https://widgets.astronomyapi.com/star-chart/generated/d22af929e98a193dda0f3d9cb274346852d823f61dba8d8d16a4a02926d5b771.png"
    var body: some View {
        if let url = URL(string: imageUrl), let imageData = try? Data(contentsOf: url) {
          Image(uiImage: UIImage(data: imageData)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
        } else {
          Image(systemName: "photo")
        }
      }
    }
    


struct ConstellationView_Previews: PreviewProvider {
    static var previews: some View {
        ConstellationView()
    }
}
