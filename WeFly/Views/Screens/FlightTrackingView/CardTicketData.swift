//
//  TicketDataCard.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI

struct CardTicketData: View {
  
  let airportCode: String
  let airportCity: String
  let time: String
  let date: String
  let isDelayed: Bool

  var alignment: CardAlignment = .left
  
  var body: some View {
    VStack(alignment: self.alignment == .left ? .leading : .trailing) {
      Text(airportCode.uppercased())
        .font(.title)
        .foregroundColor(.black)
        .fontWeight(.black)
      
      Text(airportCity)
        .font(.caption)
        .foregroundColor(.grayWeFly)
      
      Spacer()
      
      HStack {
        if self.alignment == .left {
          Image(systemName: "clock")
            .font(.system(size: 13, weight: .bold))
          Text(time.uppercased())
            .fontWeight(.heavy)
        } else if self.alignment == .right {
          Text(time.uppercased())
            .fontWeight(.heavy)
          Image(systemName: "clock")
            .font(.system(size: 13, weight: .bold))
        }
      }
      .foregroundColor(.black)
      .font(.system(size: 13))
      .padding(.vertical, 2)
      .padding(.horizontal, 3)
      .background( isDelayed ? Color.yellowWeFly : Color.clear)
      
      Text(date)
        .font(.caption)
        .foregroundColor(.grayWeFly)
    }
  }
}


//MARK: - PREVIEW

struct TicketDataCard_Previews: PreviewProvider {
    static var previews: some View {
      CardTicketData(airportCode: "LHR", airportCity: "London", time: "11:00 AM", date: "Fri, 25 Sep", isDelayed: true)
        .previewLayout(.fixed(width: 200, height: 250))
        .background(Color.blueWeFly)
    }
}
