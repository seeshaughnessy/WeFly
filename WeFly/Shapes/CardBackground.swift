//
//  CardTicketShape.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

struct CardTicketShape: Shape {
  private var hasTopDivet: Bool
  
  func path(in rect: CGRect) -> Path {
    var shape = Path()
    
    let width: CGFloat = rect.size.width
    let height: CGFloat = rect.size.height
    let offset: CGFloat = 20
    
    let hOffset1: CGFloat = 5
    let hOffset2: CGFloat = 9
    
    let midWidth: CGFloat = width / 2
    let wOffset1: CGFloat = 13
    let wOffset2: CGFloat = 30
    
    let wControl: [CGFloat] = [5, 8, 10, 17, 25]
    
    shape.move(to: CGPoint(x: width, y: offset))
    
    // Top right corner
    shape.addCurve(to: CGPoint(x: width - offset, y: 0), control1: CGPoint(x: width, y: offset / 2), control2: CGPoint(x: width - offset / 2, y: 0))
    shape.addCurve(to: CGPoint(x: midWidth + wOffset2, y: 0), control1: CGPoint(x: width - offset, y: 0), control2: CGPoint(x: midWidth + wOffset2, y: 0))
    
    if hasTopDivet {
      //Divet
      shape.addCurve(to: CGPoint(x: midWidth + wOffset1, y: hOffset1), control1: CGPoint(x: midWidth + wControl[4], y: 0), control2: CGPoint(x: midWidth + wControl[3], y: 0))
      shape.addCurve(to: CGPoint(x: midWidth, y: hOffset2), control1: CGPoint(x: midWidth + wControl[2], y: 8), control2: CGPoint(x: midWidth + wControl[0], y: hOffset2))
      shape.addCurve(to: CGPoint(x: midWidth - wOffset1, y: hOffset1), control1: CGPoint(x: midWidth - wControl[0], y: hOffset2), control2: CGPoint(x: midWidth - wControl[1], y: 8))
      shape.addCurve(to: CGPoint(x: midWidth - wOffset2, y: 0), control1: CGPoint(x: midWidth - wControl[3], y: 0), control2: CGPoint(x: midWidth - wControl[4], y: 0))
    }
    
    // Top left corner
    shape.addCurve(to: CGPoint(x: offset, y: 0), control1: CGPoint(x: offset, y: 0), control2: CGPoint(x: offset, y: 0))
    shape.addCurve(to: CGPoint(x: 0, y: offset), control1: CGPoint(x: hOffset2, y: 0), control2: CGPoint(x: 0, y: offset / 2))
    
    // Bottom left corner
    shape.addLine(to: CGPoint(x: 0, y: height - offset))
    shape.addCurve(to: CGPoint(x: offset, y: height), control1: CGPoint(x: 0, y: height - hOffset2), control2: CGPoint(x: hOffset2, y: height))
    shape.addCurve(to: CGPoint(x: midWidth - wOffset2, y: height), control1: CGPoint(x: offset, y: height), control2: CGPoint(x: offset, y: height))
    
    // Divet
    shape.addCurve(to: CGPoint(x: midWidth - wOffset1, y: height - hOffset1), control1: CGPoint(x: midWidth - wControl[4], y: height), control2: CGPoint(x: midWidth - wControl[3], y: height))
    shape.addCurve(to: CGPoint(x: midWidth, y: height - hOffset2), control1: CGPoint(x: midWidth - wControl[2], y: height - 8), control2: CGPoint(x: midWidth - wControl[0], y: height - hOffset2))
    shape.addCurve(to: CGPoint(x: midWidth + wOffset1, y: height - hOffset1), control1: CGPoint(x: midWidth + wControl[0], y: height - hOffset2), control2: CGPoint(x: midWidth + wControl[1], y: height - 8))
    shape.addCurve(to: CGPoint(x: midWidth + wOffset2, y: height), control1: CGPoint(x: midWidth + wControl[3], y: height), control2: CGPoint(x: midWidth + wControl[4], y: height))
    
    //Bottom right corner
    shape.addCurve(to: CGPoint(x: width - offset, y: height), control1: CGPoint(x: width - offset, y: height), control2: CGPoint(x: width - offset, y: height))
    shape.addCurve(to: CGPoint(x: width, y: height - offset), control1: CGPoint(x: width - offset / 2, y: height), control2: CGPoint(x: width, y: height - hOffset2))
    
    shape.addLine(to: CGPoint(x: width, y: offset))
    
    shape.closeSubpath()
    
    return shape
  }
  
  init(hasTopDivet: Bool = true) {
    self.hasTopDivet = hasTopDivet
  }
}

struct PassBackground_Previews: PreviewProvider {
    static var previews: some View {
      ZStack {
       CardTicketShape()
          .frame(width: 300, height: 150)
          .foregroundColor(.blueWeFly)
        
      } //: ZStack
    }
}
