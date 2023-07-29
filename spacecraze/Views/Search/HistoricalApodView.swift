//
//  HistoricalApodView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/26/23.
//

import SwiftUI
import AVKit

struct HistoricalApodView: View {
    @State private var isDownloaded = false
    let selectedDate: Date
    @EnvironmentObject private var viewModel: HistoricalViewModel

    var body: some View {
        ScrollView{
                gatherPhoto
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            historicalApodDescription
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThickMaterial)
    }
}

struct HistoricalApodView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalApodView(selectedDate: Date())
            .environmentObject(HistoricalViewModel())

    }
}

extension HistoricalApodView {
    
    private var gatherPhoto: some View {
        VStack {
          if let historical = viewModel.historical {
              if let imageURL = historical.hdurl, let media = historical.mediaType {
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
                        // Add a static image for if nothing populates
                        Text(historical.title ?? "")
                    }
                  }
            }
          } else {
              // Add a static image for if nothing populates
              Text("")  // Placeholder
          }
        }
        .onAppear { viewModel.fetchImageOfThatDay(certainDate: selectedDate)
            
        }
    }
    
    
    private var historicalApodDescription: some View {
        VStack (alignment: .leading, spacing:20){
            if let historical = viewModel.historical {
                Button {
                        let task = URLSession.shared.dataTask(with: historical.hdurl!) {data, _, _ in
                            guard let data = data else {return}

                            DispatchQueue.main.async {
                                UIImageWriteToSavedPhotosAlbum(UIImage(data: data)!, nil, nil, nil)
                                isDownloaded = true

                            }
                        }
                          task.resume()
                    }
                      label: {
                    Image(systemName: "square.and.arrow.down")
                }
                      .alert("Image Downloaded", isPresented: $isDownloaded) {
                          Button("Ok", role: .cancel) {}
                      }

                Text(historical.title ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(historical.title ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(historical.explanation ?? "")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .tint(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
