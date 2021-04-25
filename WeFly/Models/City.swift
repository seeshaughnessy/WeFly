//
//  City.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/15/21.
//

import Foundation

struct City: Codable, Identifiable, Hashable {
  let id = UUID()
  let iata: String
  let city: String
  let secondary: String
  
  enum CodingKeys: String, CodingKey {
    case iata = "iata"
    case city = "city"
    case secondary = "secondary"
  }
}
