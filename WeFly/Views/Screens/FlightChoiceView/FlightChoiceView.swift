//
//  FlightChoiceView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/14/21.
//

import SwiftUI

struct FlightChoiceView: View {
  
  //MARK: - PROPERTIES
  
  @EnvironmentObject var vm: FlightResultsViewModel
  let flightNumber : String
  let airline : String
  let departureAirport : String
  let arrivalAirport : String
  let departureDate : String
  //MARK: - BODY
  

  var body: some View {
    
      ScrollView {
        VStack {
          Text("Which one is yours?")
            .font(.title3)
            .padding(30)
          
          ForEach(vm.flightResults, id: \.id) { flight in
            NavigationLink(
              destination: FlightTrackingView(selectedFlight: flight),
              label: {
                FlightChoiceRowView(
                  flightNumber: flight.flight.iata!,
                  departureTime: vm.dateToTimeString((flight.departure.scheduled)),
                  departureAirport: flight.departure.iata!,
                  departureCity: vm.getCity(from: flight.departure.iata),
                  arrivalAirport: flight.arrival.iata!,
                  arrivalCity: vm.getCity(from: flight.arrival.iata))
              })
          }
          
          Spacer()
          
        }
        .frame(maxWidth: .infinity)
      }
      .navigationBarTitleDisplayMode(.inline)
      .onAppear(perform: {
        getFlightResults()
      })
    .background(Color.darkGrayWeFly2)
  }
  
  func getFlightResults() {
    var queries = [ApiQuery : String]()
    
    if !flightNumber.isEmpty {
      queries = [
        .flightNumber : flightNumber,
        .airline : airline
      ]
    } else {
      queries = [
        .airline : airline,
        .departure : departureAirport,
        .arrival : arrivalAirport,
        .date : departureDate
      ]
    }
//    vm.getFlightResults(with: queries)
  }
}

//MARK: - PREVIEW

struct FlightChoiceView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightChoiceView(flightNumber: "AW193", airline: "American Airlines", departureAirport: "Denver", arrivalAirport: "NYC", departureDate: "2021-10-04")
        .environmentObject(FlightResultsViewModel())
    }
  }
}


