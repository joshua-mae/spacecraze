//
//  DetailButtonView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/26/23.
//

import SwiftUI

struct DetailButtonView: View {
    @EnvironmentObject private var viewModel: APODViewModel

    var body: some View {
        if let apod = viewModel.apod {
            ScrollView{
                VStack{
                    Text("More Information (Stats for nerds)")
                        .font(.title)
                    Group{
                        HStack{
                            Text("Title:")
                            Text(apod.title ?? "")
                        }
                        HStack{
                            Text("Date:")
                            Text(apod.date ?? "")
                        }
                        HStack{
                            Text("Media Type:")
                            Text(apod.mediaType ?? "")
                        }
                        HStack{
                            Text("API Service Version:")
                            Text(apod.serviceVersion ?? "")
                        }
                    }
                    .font(.headline)
                    .padding()

                }
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
        }

    }
}

struct DetailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailButtonView()
            .environmentObject(APODViewModel())
    }
}
