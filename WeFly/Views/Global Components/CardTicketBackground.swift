//
//  Pass.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI

struct CardTicketBackground: View {
  
  //MARK: - PROPERTIES
  var hasTopDivet: Bool = true
  var backgroundColor: Color = .blueWeFly
  
  //MARK: - BODY
  
  var body: some View {
    GeometryReader { geo in
      CardTicketShape(hasTopDivet: hasTopDivet)
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .foregroundColor(backgroundColor)
        .overlay(
          ZStack {
            LinearGradient(gradient: Gradient(colors: [
              Color.black.opacity(0.0),
              Color.black.opacity(0.0),
              Color.black.opacity(0.0),
              Color.black.opacity(0.05),
              Color.black.opacity(0.1),
              Color.black.opacity(0.05),
              Color.black.opacity(0.0),
              Color.black.opacity(0.0),
              Color.black.opacity(0.0)
            ]),
            startPoint: .leading, endPoint: .trailing)
            .blendMode(.darken)
            
            Circles(numberOfCircles: 6, spacing: 40, width: geo.size.width + 50, height: geo.size.height + 100)
              .blendMode(.darken)
              .offset(x: 0, y: geo.size.height / 2)
          }
          .clipped()
        )
    }
    
  }
}

//MARK: - PREVIEW

struct Pass_Previews: PreviewProvider {
  static var previews: some View {
    CardTicketBackground()
      .frame(width: 400, height: 200, alignment: .center)
  }
}
