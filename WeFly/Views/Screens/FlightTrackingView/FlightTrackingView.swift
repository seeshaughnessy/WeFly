//
//  FlightTrackingView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI
import CoreLocation

struct FlightTrackingView: View {
  
  @EnvironmentObject var vm : FlightResultsViewModel
  
  //MARK: - PROPERTIES
  var cardHeight: CGFloat = 250
  var cardOffset1: CGFloat { cardHeight - 160 } // 90
  var cardOffset2: CGFloat { cardHeight - 90 } // 160
  
  var selectedFlight: FlightInfo
  
  @State var animated = false
  @State var hasDelay = false
  
  @State private var selectedTransit = 0
  @State var isByCar = true
  
  //MARK: - BODY
  
  var body: some View {
    VStack {
      Group {
        ZStack {
          FlightInfoCard(cardHeight: cardHeight)
            .zIndex(2)
            .rotation3DEffect(.degrees(animated ? 0.0 : 180.0), axis: (x: -1.0, y: 0.0, z: 0.0))
//            .offset(x: 0, y: animated ? 0 : -20)
            .animation(.easeInOut(duration: 0.75))
          
          TerminalCard(cardHeight: cardHeight)
            .zIndex(1)
            .offset(x: 0, y: animated ? cardOffset1 : 0)
            .animation(.spring())
          
          
          if let delay = selectedFlight.departure.delay {
            
            DelayCard(cardHeight: cardHeight, delayMinutes: delay, hasDelay: $hasDelay)
              .zIndex(0)
              .offset(x: 0, y: hasDelay ? cardOffset2 : 0)
              .opacity(hasDelay ? 1.0 : 0.0)
              .animation(.spring())
              .onAppear(perform: {
                self.hasDelay = true
              })
          }
        }
        .onAppear(perform: {
          animated.toggle()
        })
        .frame(height: cardHeight + (hasDelay ? cardOffset2 : cardOffset1), alignment: .top)
      }
      
      Spacer()
      
      VStack(spacing: 20) {
        TaskListItemView(
          flight: selectedFlight,
          title: "Online check-in",
          subTitle: "Finish in",
          timerOffset: .checkinOnline)
        TaskListItemView(
          flight: selectedFlight,
          title: "Check-in counter",
          subTitle: "Closes in",
          timerOffset: .checkinCounter)
        TaskListItemView(
          flight: selectedFlight,
          title: "Boarding",
          subTitle: "Starts in",
          timerOffset: .boarding)
      }
      .padding(.horizontal, 30)
      
      Spacer()
      
      TransitPickerView(isByCar: $isByCar, autoTime: vm.transitTime, flight: selectedFlight)
      
      Spacer()
      
    }
    .onAppear(perform: {
      vm.selectedFlight = self.selectedFlight
    })
    //    .ignoresSafeArea()
    .animation(.spring())
  }
  
  
}

//MARK: - PREVIEW

struct FlightTrackingView_Previews: PreviewProvider {
  static let flights = FlightResultsViewModel()
  static let flight = flights.flightResults[0]
  static var previews: some View {
    FlightTrackingView( selectedFlight: flight)
      .environmentObject(FlightResultsViewModel())
  }
}


