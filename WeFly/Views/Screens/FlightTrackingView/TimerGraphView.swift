//
//  TimerGraphView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/18/21.
//

import SwiftUI

struct TimerGraphView: View {
  
  //MARK: - PROPERTIES
  let accentColor: Color
  let timeRemaining: Double
  let totalTime: Double
  
  var endAngle: Angle {
    var percentage = timeRemaining / totalTime
    if percentage > abs(2) { percentage = 1 }
    let angle = percentage * 360
    
    return Angle(degrees: -angle)
  }
  
  var isSurplusTime: Bool { timeRemaining > totalTime }
  
  //MARK: - BODY
  
    var body: some View {
      GeometryReader { geo in
        Path { path in
          path.move(to: CGPoint(x: geo.size.width / 2, y: geo.size.width / 2))
          path.addArc(center: CGPoint(x: geo.size.width / 2, y: geo.size.width / 2), radius: geo.size.width / 2, startAngle: Angle(degrees: 0), endAngle: endAngle, clockwise: false)
        }
        .fill(isSurplusTime ? accentColor : Color.darkGrayWeFly)
        .background(
          Circle()
            .foregroundColor(isSurplusTime ? .darkGrayWeFly : accentColor)
        )
        .overlay(
          Circle()
            .foregroundColor(.black)
            .frame(width: geo.size.width - 10, height: geo.size.height - 10, alignment: .center)
            .overlay(
              Circle()
                .foregroundColor(accentColor)
                .frame(width: 10, height: 10, alignment: .center)
            )
        )
        .rotationEffect(Angle(degrees: -90))
      }
    }
}

//MARK: - PREVIEW

struct TimerGraphView_Previews: PreviewProvider {
    static var previews: some View {
      TimerGraphView(accentColor: .greenWeFly, timeRemaining: 240, totalTime: 240)
          .previewLayout(.fixed(width: 50, height: 50))
    }
}
