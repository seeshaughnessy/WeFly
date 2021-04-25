//
//  CardTicketShape.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

struct Square: View {
  
  static let symbolColor = Color.blueWeFly

  
  var body: some View {
    
    GeometryReader { geometry in
        Path { path in
            let width = min(geometry.size.width, geometry.size.height)
            let height = width
            let spacing = width * 0.0

            path.addLines([
                CGPoint(x: spacing, y: spacing),
                CGPoint(x: width, y: spacing),
                CGPoint(x: width, y: height),
                CGPoint(x: spacing, y: height),
            ])
        }
        .stroke(Self.symbolColor)
    }
    
  }
}

struct Square_Previews: PreviewProvider {
  static var previews: some View {
    Square()
      .frame(width: 300, height: 300, alignment: .center)
      .background(Color.black)
      .border(Color.red)
  }
}
