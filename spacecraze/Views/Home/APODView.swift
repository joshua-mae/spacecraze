//
//  APODView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

import SwiftUI
import AVKit
import UIKit

struct APODView: View {

    @EnvironmentObject private var viewModel: APODViewModel
    @State private var infoIsShowing = false
    @State private var isDownloaded = false
    

    
    
    
    var body: some View {
      
      NavigationView {
          ScrollView{
              VStack {
                  photoBomb
                      .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                  apodDescription
              }
          }
          .background(.ultraThickMaterial)
          .navigationTitle("Astronomy Photo Of the Day")
          .toolbar {
              ToolbarItem(placement: .navigationBarLeading) {
                  Button {

                  infoIsShowing = true

                  } label: {

                  Image(systemName: "info.circle")

                  }

                  .alert("Stats for nerds",isPresented: $infoIsShowing) {
                      Button("Copy Source", role: .cancel) {
                          UIPasteboard.general.string = viewModel.apod.hdurl
                    
                }
                  Button("Ok") {}

                  } message: {
                      Text("TITLE: \(viewModel.apod.title)\nDATE: \(viewModel.apod.date)\nMEDIA TYPE: \(viewModel.apod.mediaType)\nSERVICE-VERSION: \(viewModel.apod.serviceVersion)\nSOURCE: \(viewModel.apod.hdurl)")
                  }
                  .tint(.primary)
              }
              ToolbarItem(placement: .navigationBarTrailing) {
                  Button {
                      guard let url = URL(string: viewModel.apod.hdurl) else { return }
                      
                      viewModel.downloadAndSaveImage(url: url)
                      isDownloaded = true

                      }
                        label: {
                      Image(systemName: "square.and.arrow.down")
                  }
                    .alert("Image Downloaded", isPresented: $isDownloaded) {
                        Button("Ok", role: .cancel) {}
                    }

                  .tint(.primary)
              }
          }
          .navigationBarTitleDisplayMode(.inline)
      }
      .navigationViewStyle(.stack)
  }
}



struct APODView_Previews: PreviewProvider {
    static var previews: some View {
        APODView()
            .environmentObject(APODViewModel())
    }
}

extension APODView {
    
    private var photoBomb: some View {
        VStack {
            if viewModel.apod.mediaType.hasSuffix("mp4") {
                VideoPlayer(player: AVPlayer(url: URL(string: viewModel.apod.hdurl.description)!))
              } else {
                  AsyncImage(url: URL(string: viewModel.apod.hdurl)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                                .clipped()
                            
                      }
                    placeholder: {
                        Text(viewModel.apod.title)
                }
            }
        }
        .onAppear { viewModel.fetchImageOfTheDay() }
    }
    
    private var apodDescription: some View {
        VStack (alignment: .leading, spacing: 10){
                
                Text(viewModel.apod.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(viewModel.apod.date)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(viewModel.apod.explanation)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}
