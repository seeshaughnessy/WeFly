//
//  Enums.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/13/21.
//

import SwiftUI

enum CardAlignment {
  case left
  case right
}

enum FlightStatus: String, Codable {
  case scheduled
  case active
  case landed
  case cancelled
  case incident
  case diverted
}

enum ApiQuery: String {
  case airline = "airline_iata"
  case departure = "dep_iata"
  case arrival = "arr_iata"
  case date = "flight_data"
  case flightNumber = "flight_number"
}

enum TimeOffset : Int {
  case checkinOnline = 1500
  case checkinCounter = 45
  case boarding = 30
}
