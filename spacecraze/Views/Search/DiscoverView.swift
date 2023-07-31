//
//  ContentView.swift
//  spacecraze
//
//  Created by Joshua Mae on 7/25/23.
//

import SwiftUI


struct DiscoverView: View {
    @State private var selectedDate = Date()
    @State private var showSheet = false
    @State private var showRandom = false
    var dateRange: ClosedRange<Date> {
      let min = Calendar.current.date(from: DateComponents(year: 1995, month: 6,day: 16))!
      let max = Date()
      return min...max
    }
    var randomDate: Date {
        let startDate = Calendar.current.date(from: DateComponents(year: 1995, month: 6, day: 20))!
        let endDate = Date()
        let days = Int.random(in: 0..<Int(startDate.distance(to: endDate)))
        return startDate.addingTimeInterval(TimeInterval(days))
    }

    var body: some View {
        ScrollView {
            VStack{
                DatePicker("Select a date", selection: $selectedDate, in: dateRange, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .clipped()
                    .onChange(of: selectedDate) { newDate in
                        selectedDate = newDate
                    }
                VStack {
                    Button {
                        showRandom.toggle()
                    } label: {
                        Text("Random Apod")
                            .frame(maxWidth: 350)
                            .frame(height: 30)
                            .font(.headline)
                    }
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Load Apod")
                            .frame(maxWidth: 350)
                            .frame(height: 30)
                            .font(.headline)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal,10)
                .padding(.vertical, 10)
                .sheet(isPresented: $showSheet, onDismiss: {
                  showSheet = false
                }) {
                  HistoricalApodView(selectedDate: selectedDate)
                }
                .sheet(isPresented: $showRandom, onDismiss: {
                  showRandom = false
                }) {
                  HistoricalApodView(selectedDate: randomDate)
                }
            }
        }
        .background(.ultraThickMaterial)
    }
}
    

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(HistoricalViewModel())
    }
}



