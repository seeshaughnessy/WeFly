//
//  Squares.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

struct Circles: View {
  
  //MARK: - PROPERTIES
  
  var numberOfCircles: Int = 5
  var spacing: Int = 25
  var width: CGFloat = 300
  var height: CGFloat = 180
  
  //MARK: - BODY
  
    var body: some View {
      ZStack {
        ForEach(0..<numberOfCircles) { i in
          Ellipse()
            .overlay(
            Ellipse()
              .stroke(Color.black.opacity(0.05), lineWidth: 1.0)
            )
            .frame(width: width - CGFloat(i * spacing) , height: height - CGFloat(i * spacing), alignment: .center)
        }
      }
    }
  
}

//MARK: - PREVIEW

struct Circles_Previews: PreviewProvider {
    static var previews: some View {
      Circles()
        .foregroundColor(.blueWeFly)
    }
}
