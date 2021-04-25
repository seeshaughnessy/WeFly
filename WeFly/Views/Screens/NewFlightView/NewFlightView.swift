//
//  NewFlightView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

struct NewFlightView: View {
  
  //MARK: - PROPERTIES
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var vm: FlightResultsViewModel
  
  @State var flightNumber = ""
  @State var airline = ""
  @State var departureAirport = ""
  @State var arrivalAirport = ""
  
  @State var departureDate = ""
  
  //MARK: - BODY
  
  var body: some View {
    NavigationView {
      ZStack {
        RadialGradient(gradient: Gradient(colors: [Color.yellowWeFly.opacity(0.3), Color.black.opacity(0.3)]), center: .bottomLeading, startRadius: 0, endRadius: 300)
          .ignoresSafeArea(.all, edges: .bottom)
        
        ScrollView(showsIndicators: false) {
          
          VStack {
            //Title
            //          HStack {
            //            Text("New flight")
            //              .fontWeight(.semibold)
            //
            //            Spacer()
            //
            //            Button(action: {
            //              presentationMode.wrappedValue.dismiss()
            //            }, label: {
            //              Image(systemName: "xmark")
            //            })
            //          }
            //          .font(.title)
            //          .padding(30)
            
            //MARK: - Call to action (Add from wallet)
            HStack {
              Image(systemName: "wallet.pass")
                .font(.title)
              
              Text("add from Wallet app")
                .fontWeight(.semibold)
            }
            .foregroundColor(.black)
            .frame(height: 90)
            .frame(maxWidth: .infinity)
            .background(
              ZStack {
                Color.blueWeFly
                
                Squares()
                  .offset(x: -100, y: 0)
                
              }
            )
            .clipped()
            
            Spacer(minLength: 30)

                //MARK: - Flight Number Fields
                VStack(spacing: 15) {
                  AirlineTextField(symbol: "airplane", placeholder: "Airline", input: $airline)
                  TextFieldView(symbol: "number", placeholder: "Flight Number", input: $flightNumber)
                    .keyboardType(.numberPad)
                }
                .padding(.horizontal, 30)
              
              
              //MARK: - Alternate flight lookup
              Spacer(minLength: 25)
              
              Group {
                
                VStack(spacing: 15) {
                  Text("Don't know your flight number?")
                    .padding(.horizontal, 30)
                  
                  CityTextField(symbol: "icloud.and.arrow.up", placeholder: "Departure Airport", input: $departureAirport)
                  
                  
                  CityTextField(symbol: "icloud.and.arrow.down", placeholder: "Arrival Airport", input: $arrivalAirport)
                  
                  DatePickerField(symbol: "calendar", input: $departureDate)
//                  TextFieldView(symbol: "calendar", placeholder: "Travel Date (YY-MM-DD)", input: $departureDate)
                  
                }
                .padding(.horizontal, 30)
            }
            
            Spacer(minLength: 25)
            
            NavigationLink(
              destination: FlightChoiceView(flightNumber: flightNumber, airline: airline, departureAirport: departureAirport, arrivalAirport: arrivalAirport, departureDate: departureDate),
              label: {
                Text("Continue")
                  .foregroundColor(.black)
                  .fontWeight(.bold)
                  .frame(height: 50)
                  .frame(maxWidth: .infinity)
                  .background(Color.white)
                  .cornerRadius(10)
                  .padding(30)
              })
            
            Spacer(minLength: 25)
            
          }
        }
      }
      .ignoresSafeArea(.container, edges: .bottom)
      .padding(.top, 20)
      .navigationBarTitleDisplayMode(.large)
      .navigationTitle("New Flight")
      
    }
  
  }
}

//MARK: - PREVIEW

struct NewFlightView_Previews: PreviewProvider {
  static var previews: some View {
    NewFlightView()
      .environmentObject(FlightResultsViewModel())
  }
}
