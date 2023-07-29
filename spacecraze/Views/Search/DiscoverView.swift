////
////  ContentView.swift
////  spacecraze
////
////  Created by Joshua Mae on 7/25/23.
////
//
//import SwiftUI
//
//struct DiscoverView: View {
//    
//    @State private var selectedDate = Date()
//    @State private var showSheet = false
//    var dateRange: ClosedRange<Date> {
//      let min = Calendar.current.date(from: DateComponents(year: 1995, month: 6))!
//      let max = Date()
//      return min...max
//    }
//    
//    
//    var body: some View {
//        ScrollView {
//            VStack{
//                DatePicker("Select a date", selection: $selectedDate, in: dateRange, displayedComponents: .date)
//                    .labelsHidden()
//                    .datePickerStyle(.graphical)
//                    .clipped()
//                    .onChange(of: selectedDate) { newDate in
//                        showSheet = true
//                    }
//                    .sheet(isPresented: $showSheet) {
//                        HistoricalApodView(selectedDate: selectedDate)
//                    }
//            }
//        }
//        .background(.ultraThickMaterial)
//    }
//}
//    
//
//struct DiscoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoverView()
//            .environmentObject(HistoricalViewModel())
//
//    }
//}
