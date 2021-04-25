//
//  DelayCard.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI

struct DelayCard: View {
  var cardHeight: CGFloat = 250
  
  var delayMinutes: Int
  @Binding var hasDelay: Bool
  
  var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Text("Flight delayed + \(delayMinutes) m")
          .fontWeight(.medium)
        Spacer()
        Image(systemName: "xmark")
          .font(.title2)
          .onTapGesture {
            self.hasDelay = false
          }
      }
    }
    .foregroundColor(.black)
    .padding(.horizontal, 30)
    .padding(.vertical, 25)
    .frame(height: cardHeight)
    .background(Color.yellowWeFly)
    .cornerRadius(20)
  }
}

//MARK: - PREVIEW

struct DelayCard_Previews: PreviewProvider {
    static var previews: some View {
      DelayCard(delayMinutes: 6, hasDelay: .constant(true))
    }
}
