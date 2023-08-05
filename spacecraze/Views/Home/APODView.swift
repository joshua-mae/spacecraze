//
//  APODView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

import SwiftUI
import UIKit
import WebKit

struct APODView: View {

    @EnvironmentObject private var viewModel: APODViewModel
    @State private var infoIsShowing = false
    @State private var isDownloaded = false
    @AppStorage("isDarkMode") private var isDarkMode = false

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
                  .alert("APOD Info",isPresented: $infoIsShowing) {
                      Button("Copy Source", role: .cancel) {
                          UIPasteboard.general.string = viewModel.apod.hdurl
                }
                  Button("Ok") {}

                  } message: {
                      Text("""
                           TITLE - \(viewModel.apod.title)
                           DATE - \(viewModel.apod.date)
                           MEDIA_TYPE - \(viewModel.apod.mediaType)
                           SERVICE_VERSION - \(viewModel.apod.serviceVersion)
                           SOURCE - \(viewModel.apod.hdurl!)
                           """)
                  }
              }
              if viewModel.apod.mediaType != "video" {
                  ToolbarItem(placement: .navigationBarTrailing) {
                      Button {
                          guard let url = URL(string: viewModel.apod.hdurl!) else { return }
                          viewModel.downloadAndSaveImage(url: url)
                          isDownloaded = true

                          }
                            label: {
                          Image(systemName: "square.and.arrow.down")
                      }
                        .alert("Image Downloaded", isPresented: $isDownloaded) {
                            Button("Ok", role: .cancel) {}
                        }
                  }
              }
              
          }
          .navigationBarTitleDisplayMode(.inline)
          .tint(.indigo)

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
            if viewModel.apod.mediaType.hasSuffix("video") {
                WebView(urlString: viewModel.apod.url)
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
              } else {
                  AsyncImage(url: URL(string: viewModel.apod.hdurl!)) { image in
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
                
            if viewModel.apod.title == "" {
                Text("The API request does not have a title for this APOD or it is out of service at this moment")
            } else {
                Text(viewModel.apod.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
            }

            if viewModel.apod.date == "" {
                Text("The API request does not have the date for this APOD or it is out of service at this moment")
            } else {
                Text(viewModel.apod.date)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
            }
            if viewModel.apod.explanation == "" {
                Text("The API request does not have the explanation for this APOD or it is out of service at this moment")
            }else {
                Text(viewModel.apod.explanation)
                        .font(.subheadline)
                        .foregroundColor(.primary)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}
