//
//  FlightInfoCard.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI

struct FlightInfoCard: View {
  var cardHeight: CGFloat = 250
  
  @EnvironmentObject var vm : FlightResultsViewModel
  
  var flight : FlightInfo? { vm.selectedFlight }
  
  var body: some View {
    ZStack {
      CardTicketBackground()
        .overlay(
          
          VStack {
            HStack {
              HStack(spacing: 15) {
//                Image(systemName: "arrow.left")
                Text(flight?.aircraft?.iata ?? "--")
                  .font(.headline)
                  .fontWeight(.bold)
                
              }
              Spacer()
              Image(systemName: "ellipsis")
            }
            .font(.title)
            .foregroundColor(.black)
            .padding(.top, 40)
            
            Spacer()
            
            HStack(alignment: .bottom) {
              CardTicketData(
                airportCode: flight?.departure.iata ?? "--",
                airportCity: vm.getCity(from: flight?.departure.iata),
                time: flight?.departure.estimatedTimeString ?? "--",
                date: flight?.departure.estimatedDateString ?? "--",
                isDelayed: flight?.departure.delay != nil
              )
              
              Spacer()
              
              CardTicketData(
                airportCode: flight?.arrival.iata ?? "--",
                airportCity: vm.getCity(from: flight?.arrival.iata),
                time: flight?.arrival.estimatedTimeString ?? "--",
                date: flight?.arrival.estimatedDateString ?? "--",
                isDelayed: flight?.arrival.delay != nil,
                alignment: .right)
            }
            .frame(height: 110)
          }
          .padding(.horizontal, 30)
          .padding(.vertical, 25)
        )
    }
    .frame(height: cardHeight, alignment: .center)
  }
}

//MARK: - PREVIEW

struct FlightInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoCard()
          .previewLayout(.fixed(width: 350, height: 200))
          .environmentObject(FlightResultsViewModel())
    }
}
