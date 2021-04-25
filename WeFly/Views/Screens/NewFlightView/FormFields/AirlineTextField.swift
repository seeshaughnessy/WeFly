//
//  AirlineTextField.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/18/21.
//

import SwiftUI

struct AirlineTextField: View {
  
  //MARK: - PROPERTIES
  
  @EnvironmentObject var vm: FlightResultsViewModel
  @State var airlines : [AirlineIata] = Bundle.main.decode("AirlineCodes.json")
  
  let symbol: String
  let placeholder: String
  
  @State var showingDropdown: Bool = false
  @State var searchText: String = ""
  @Binding var input: String
  
  //MARK: - BODY
  
    var body: some View {
      VStack {
        HStack(spacing: 0) {
          Image(systemName: symbol)
            .font(.title)
            .frame(width: 50, height: 50, alignment: .leading)
          
          TextField(placeholder, text: $searchText) { (isEditing) in
            showingDropdown = isEditing
          }
          .padding(15)
          .background(Color.darkGrayWeFly)
          .cornerRadius(10)
          .autocapitalization(.words)
        }
        .foregroundColor(input != "" ? .white : .lightGrayWeFly)
        
        if showingDropdown && !searchText.isEmpty {
          
          ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
              ForEach(airlines.filter { $0.airline.localizedCaseInsensitiveContains(searchText)}) { airline in
                VStack(alignment: .leading, spacing: 3) {
                  HStack {
                    Text(airline.airline)
                    Text("(\(airline.iata))")
                      .foregroundColor(.lightGrayWeFly)
                  }
                  .onTapGesture(perform: {
                    input = airline.iata
                    searchText = airline.airline
                    showingDropdown.toggle()
                })
                  Text("\(airline.country)")
                    .foregroundColor(.lightGrayWeFly)
                }
                .padding(.vertical, 5)
//                .padding(.vertical, 2)
              }
            }
            .padding(.leading, 50)
          }
          
//          .background(
//            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom
//            )
//          )
          .frame(height: 300)
        }
        
      }
    }
}
  
//MARK: - PREVIEW

struct AirlineTextField_Previews: PreviewProvider {
    static var previews: some View {
      CityTextField(symbol: "paperplane.circle", placeholder: "Airport", input: .constant(""))
        .environmentObject(FlightResultsViewModel())
    }
}
