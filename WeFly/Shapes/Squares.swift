//
//  Squares.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

struct Squares: View {
  
  //MARK: - PROPERTIES
  
  let angle: Double = 30
  let numberOfSquares: Int = 5
  let multiplier: Int = 25
  let size: CGFloat = 180
  
  //MARK: - BODY
  
    var body: some View {
      ZStack {
        ForEach(0..<numberOfSquares) { i in
          Square()
            .border(Color.black.opacity(0.05))
            .frame(width: size - CGFloat(i * multiplier), height: size - CGFloat(i * multiplier), alignment: .center)
            .rotationEffect(Angle(degrees: angle), anchor: .center)
        }
      }
    }
  
}

//MARK: - PREVIEW

struct Squares_Previews: PreviewProvider {
    static var previews: some View {
        Squares()
      
    }
}
