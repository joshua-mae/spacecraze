//
//  APODView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

// Handle videos and images

import SwiftUI
import AVKit

struct APODView: View {

  @EnvironmentObject private var viewModel: APODViewModel
    @State private var isShowing = false

    
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
                      isShowing = true
                  } label: {
                      Image(systemName: "info.circle")
                  }
                  .overlay(alignment: .bottom) {
                      if isShowing{
                          DetailButtonView()
                      }
                  }
                  .ignoresSafeArea()

                  .tint(.primary)
              }
              ToolbarItem(placement: .navigationBarTrailing) {
                  Button {
                      if let apod = viewModel.apod {
                          let task = URLSession.shared.dataTask(with: apod.hdurl!) {data, _, _ in
                              guard let data = data else {return}
                              
                              DispatchQueue.main.async {
                                  UIImageWriteToSavedPhotosAlbum(UIImage(data: data)!, nil, nil, nil)
                                  isShowing = true
                              }
                              
                          }
                            task.resume()
                      }
                      

                      }
                  

                        label: {
                      Image(systemName: "square.and.arrow.down")
                  }
                        .alert("Image Downloaded", isPresented: $isShowing) {
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
          if let apod = viewModel.apod {
              if let imageURL = apod.hdurl, let media = apod.mediaType {
                  if media.hasSuffix("mp4") {
                      VideoPlayer(player: AVPlayer(url: URL(string: imageURL.description)!))
              } else {
                      AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                                .clipped()
                      }
                    placeholder: {
                        Text(apod.title ?? "The beautiful space image is not loading :(")
                }
                  }
            }
          } else {
              Text("The beautiful space image is not loading :(")  // Placeholder
          }
        }
        .onAppear { viewModel.fetchImageOfTheDay() }
    }
    
    private var apodDescription: some View {
        VStack (alignment: .leading, spacing: 10){
            if let apod = viewModel.apod {
                
                Text(apod.title ?? "This has no title")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(apod.explanation ?? "This has no explanation")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}
