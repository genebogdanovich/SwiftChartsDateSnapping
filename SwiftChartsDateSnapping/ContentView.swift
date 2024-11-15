//
//  ContentView.swift
//  SwiftChartsDateSnapping
//
//  Created by Gene Bogdanovich on 15.11.24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var selection: Date = .now
    @State private var dates = [Date]()
    
    private let fifteenDays: TimeInterval = 3600*24*15
    
    var body: some View {
        VStack {
            Text(selection.formatted())
            
            Chart(dates, id: \.self) { date in
                BarMark(
                    x: .value("Date", date, unit: .day),
                    y: .value("Number", 1)
                )
                .annotation {
                    Text(date.formatted(.dateTime.day()))
                        .font(.caption2)
                }
            }
            .chartXAxis {
                AxisMarks(format: .dateTime.day())
            }
            
            .chartScrollableAxes(.horizontal)
            .chartScrollTargetBehavior(.valueAligned(matching: DateComponents(hour: 0)))
            .chartXVisibleDomain(length: fifteenDays)
            .chartScrollPosition(x: $selection)
            .aspectRatio(1, contentMode: .fit)
            .padding()
            .onAppear {
                self.dates = (0...400).map { Calendar.current.date(byAdding: .day, value: -$0, to: .now)! }
            }
        }
    }
}

#Preview {
    ContentView()
}
