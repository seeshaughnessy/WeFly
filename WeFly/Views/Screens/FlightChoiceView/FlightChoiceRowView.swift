//
//  FlightChoiceRowView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/19/21.
//

import SwiftUI

struct FlightChoiceRowView: View {
  
  let flightNumber: String
  let departureTime: String
  let departureAirport: String
  let departureCity: String
  let arrivalAirport: String
  let arrivalCity: String
  
  var body: some View {
        HStack {
          VStack(alignment: .leading, spacing: 4) {
            Text(flightNumber)
              .font(.body)
              .fontWeight(.bold)
            Text(departureTime.uppercased())
              .font(.footnote)
          }
          
          Spacer()
          
          Image(systemName: "airplane")
            .foregroundColor(Color.grayWeFly.opacity(0.5))
            .font(.body)
          
          Spacer()
          
          VStack(alignment: .leading) {
            Text(departureAirport.uppercased())
              .font(.title2)
              .fontWeight(.bold)
            Text(departureCity.capitalized)
              .font(.footnote)
          }
          .foregroundColor(.grayWeFly)
          
          Spacer()
          
          VStack(alignment: .leading) {
            Text(arrivalAirport.uppercased())
              .font(.title2)
              .fontWeight(.bold)
            Text(arrivalCity.capitalized)
              .font(.footnote)
          }
          .foregroundColor(.grayWeFly)
          
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.darkGrayWeFly)
        .cornerRadius(20)
        //    .overlay(
        //      RoundedRectangle(cornerRadius: 20)
        //        .stroke(Color.primary, lineWidth: 1)
        //    )
        .padding(.horizontal, 30)
        
  }
}

//MARK: - PREVIEW

struct FlightChoiceRowView_Previews: PreviewProvider {
    static var previews: some View {
      FlightChoiceRowView(flightNumber: "A302", departureTime: "2021-04-20", departureAirport: "DEN", departureCity: "Denver", arrivalAirport: "CHI", arrivalCity: "Chicago")
    }
}
