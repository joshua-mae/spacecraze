//
//  HistoricalApodView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/26/23.
//

import SwiftUI
import UIKit
import WebKit

struct WebView : UIViewRepresentable {

  let urlString: String

  func makeUIView(context: Context) -> WKWebView  {
    return WKWebView()
  }

  func updateUIView(_ uiView: WKWebView, context: Context) {
    guard let url = URL(string: urlString) else { return }
    let request = URLRequest(url: url)
    uiView.load(request)
  }
}

struct HistoricalApodView: View {
    @State private var isDownloaded = false
    let selectedDate: Date
    @EnvironmentObject private var viewModel: HistoricalViewModel

    var body: some View {
        ScrollView{
                gatherPhoto
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            if viewModel.historical.mediaType != "video" {
                HStack{
                    downloadButton
                    Spacer()
                }
                .padding(.horizontal,20)
                .padding(.top,10)
            }
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
                  if viewModel.historical.mediaType.hasSuffix("video") {
                          WebView(urlString: viewModel.historical.url)
                          .frame(maxWidth: .infinity)
                          .frame(height: 400)
                  } else {
                  AsyncImage(url: URL(string: viewModel.historical.hdurl!)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                                .clipped()
                      }
                    placeholder: {
                        Text(viewModel.historical.title)
                    }
                  }
        }
        .onAppear { viewModel.fetchImageOfThatDay(certainDate: selectedDate)
            
        }
    }
    
    
    private var historicalApodDescription: some View {
        VStack (alignment: .leading, spacing:10){
            if viewModel.historical.title == "" {
                Text("The API request does not have a title for this APOD")
            } else {
                Text(viewModel.historical.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
            }

            if viewModel.historical.date == "" {
                Text("The API request does not have the date for this APOD")
            } else {
                Text(viewModel.historical.date)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
            }
            if viewModel.historical.explanation == "" {
                Text("The API request does not have the explanation for this APOD")
            }else {
                Text(viewModel.historical.explanation)
                        .font(.subheadline)
                        .foregroundColor(.primary)
            }

            
        }
        .tint(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var downloadButton : some View {
        Button {
            guard let url = URL(string: viewModel.historical.hdurl!) else { return }
            let task = URLSession.shared.dataTask(with: url) {data, _, _ in
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
    }
}
