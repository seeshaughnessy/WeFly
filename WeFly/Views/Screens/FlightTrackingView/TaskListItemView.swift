//
//  TaskListItemView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/19/21.
//

import SwiftUI

struct TaskListItemView: View {
  @EnvironmentObject private var vm : FlightResultsViewModel
  
  var flight: FlightInfo
  var title: String
  var subTitle: String
  var timerOffset: TimeOffset
  
  var body: some View {
    VStack {
      HStack(spacing: 15) {
        // Timer Circle Graph
        TimerGraphView(
          accentColor: vm.countdownColor(to: flight.departure.estimated, offset: timerOffset),
          timeRemaining: vm.countdownInMinutes(with: timerOffset), totalTime: 240)
          .frame(width: 50, height: 50, alignment: .center)
        
        // Task
        VStack(alignment: .leading, spacing: 5) {
          Text(title)
          Text(subTitle)
            .font(.caption)
            .foregroundColor(.lightGrayWeFly)
        }
        
        Spacer()
        
        // Time remaining
        Text(vm.countdown(to: flight.departure.estimated, offset: timerOffset))
          .foregroundColor(vm.countdownColor(to: flight.departure.estimated, offset: timerOffset))
      }
    }
  }
}

//MARK: - PREVIEW

struct TaskListItemView_Previews: PreviewProvider {
  static let flights = FlightResultsViewModel()
  static let flight = flights.flightResults[0]
  
    static var previews: some View {
      TaskListItemView(flight: flight, title: "Checkin Online", subTitle: "Starts in", timerOffset: .checkinOnline)
          .environmentObject(FlightResultsViewModel())
        .previewLayout(.sizeThatFits)
    }
}
