//
//  TerminalCard.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI

struct TerminalCard: View {
  
  @EnvironmentObject var vm : FlightResultsViewModel
  
  var flight : FlightInfo? { vm.selectedFlight }
  
  var cardHeight: CGFloat = 250
  
  var body: some View {
    VStack {
      Spacer()
      
      HStack {
        VStack {
          HStack {
            Text("Terminal")
              .foregroundColor(.lightGrayWeFly)
            Text("\(flight?.departure.terminal ?? "--")")
              .fontWeight(.bold)
          }
          HStack {
            Text("Gate")
              .foregroundColor(.lightGrayWeFly)
            Text("\(flight?.departure.gate ?? "--")")
              .fontWeight(.bold)
          }
        }
        
        Spacer()
        
        VStack {
          HStack {
            Text("\(flight?.arrival.terminal ?? "--")")
              .fontWeight(.bold)
            Text("Terminal")
              .foregroundColor(.lightGrayWeFly)
          }
          HStack {
            Text("\(flight?.arrival.terminal ?? "--")")
              .fontWeight(.bold)
            Text("Gate")
              .foregroundColor(.lightGrayWeFly)
          }
        }
      }
    }
    .padding(.horizontal, 30)
    .padding(.vertical, 25)
    .frame(height: cardHeight)
    .background(
      ZStack {
        Color.darkGrayWeFly2
        RadialGradient(gradient: Gradient(colors: [Color.yellowWeFly.opacity(0.4), Color.black.opacity(0.3)]), center: .topLeading, startRadius: 0, endRadius: 350)
      }
    )
    .cornerRadius(20)
  }
}

//MARK: - PREVIEW

struct TerminalCard_Previews: PreviewProvider {
    static var previews: some View {
        TerminalCard()
          .environmentObject(FlightResultsViewModel())
    }
}
