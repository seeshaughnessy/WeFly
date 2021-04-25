//
//  Airline.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/19/21.
//

import Foundation

struct AirlineIata: Codable, Identifiable, Hashable {
  var id = UUID()
  let airline: String
  let iata: String
  let country: String
  
  enum CodingKeys: String, CodingKey {
    case airline = "airline"
    case iata = "iata"
    case country = "country"
  }
}
