//
//  TransitPickerView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI

struct TransitPickerView: View {
  @EnvironmentObject var vm : FlightResultsViewModel
  
  @Binding var isByCar: Bool
  var autoTime: String
  var flight: FlightInfo
  
  var body: some View {
    ZStack {
      Capsule()
        .foregroundColor(.darkGrayWeFly)
      
      
      HStack {
        //By Car
        Capsule()
          .stroke()
          .opacity(isByCar ? 1.0 : 0.0)
          .animation(.easeIn)
          .overlay(
            HStack(spacing: 15) {
              Text("by Car")
              Text(vm.autoTime)
                .font(.footnote)
                .foregroundColor(.lightGrayWeFly)
            }
//            .onAppear(perform: {
//              vm.getTransitTime(with: flight, transitType: .automobile)
//            })
          )
          .onTapGesture {
            isByCar = true
          }
        
        Spacer()
        
        //By Transit
        Capsule()
          .stroke()
          .opacity(isByCar ? 0.0 : 1.0)
          .overlay(
            HStack(spacing: 15) {
              Text("by Transit")
              Text(vm.transitTime)
                .font(.footnote)
                .foregroundColor(.lightGrayWeFly)
            }
            .onAppear(perform: {
              vm.getTransitTime(with: flight, transitType: .automobile)
              vm.getTransitTime(with: flight, transitType: .transit)
            })
          )
          .onTapGesture {
            isByCar = false
          }
        
      }
    }
    .frame(height: 50)
    .padding(.horizontal, 30)
  }
}

//MARK: - PREVIEW

struct TransitPickerView_Previews: PreviewProvider {
  static let vm = FlightResultsViewModel()
  
    static var previews: some View {
      TransitPickerView(isByCar: .constant(true), autoTime: "2m", flight: vm.flightResults[0])
          .previewLayout(.sizeThatFits)
        .environmentObject(FlightResultsViewModel())
    }
}
