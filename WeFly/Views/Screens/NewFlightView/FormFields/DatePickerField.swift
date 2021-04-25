//
//  DatePickerField.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/19/21.
//

import SwiftUI

struct DatePickerField: View {
  
  //MARK: - PROPERTIES
  @EnvironmentObject var vm : FlightResultsViewModel
  
  let symbol: String
  
  @State var date: Date = Date()
  
  @State var showingDropdown: Bool = false
  private var selectedDate: Binding<Date> {
     Binding<Date>(get: { self.date }, set : {
         self.date = $0
         self.setDateString()
      self.showingDropdown = false
     })
   }
  
  @Binding var input: String
  
  //MARK: - BODY
  
  var body: some View {
      ZStack {
        HStack(spacing: 0) {
          Image(systemName: symbol)
            .font(.title)
            .frame(width: 50, height: 50, alignment: .leading)
          
          Button(action: {
            showingDropdown = true
          }, label: {
            Text(input)
            Spacer()
          })
          .padding(15)
          .frame(maxWidth: .infinity)
          .background(Color.darkGrayWeFly)
          .cornerRadius(10)
        }
        .onAppear(perform: {
          self.setDateString()
        })

        if showingDropdown {
            DatePicker("Departure Date",
                       selection: selectedDate,
                       in: Date()...,
                       displayedComponents: .date)
              .datePickerStyle(GraphicalDatePickerStyle())
              .background(Color.black)
        }
      }
      
      
      
    }
  // To take the selected date and store it as a string for the text field
  private func setDateString() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    self.input = formatter.string(from: self.date)
  }
  }



//MARK: - PREVIEW

struct DatePickerField_Previews: PreviewProvider {
  static var previews: some View {
    DatePickerField(symbol: "calendar", input: .constant("2021"))
  }
}
