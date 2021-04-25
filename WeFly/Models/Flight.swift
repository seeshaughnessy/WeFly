//
//  Flight.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/14/21.
//

import Foundation

struct FlightJson: Codable {
  let pagination : Pagination
  let data : [FlightInfo]
}

struct Pagination: Codable {
  let limit : Int?
  let offset : Int?
  let count : Int?
  let total : Int?
}

struct FlightInfo: Codable, Identifiable {
  
  let id = UUID()
  let flight_date : String?
  let flight_status : String?
  let departure : Departure
  let arrival : Arrival
  let airline : Airline
  let flight : Flight
  let aircraft : Aircraft?
  let live : Live?
  
  private enum CodingKeys : String, CodingKey {
    case flight_date = "flightDate"
    case flight_status = "flightStatus"
    case departure
    case arrival
    case airline
    case flight
    case aircraft
    case live
  }
  
  struct Aircraft : Codable {
    let registration : String
    let iata : String
    let icao : String
    let icao24 : String
  }
  
  struct Live: Codable {
    let updated: String?
    let latitude: Double?
    let longitude: Double?
    let altitude: Double?
    let direction: Double?
    let speed_horizontal: Double?
    let speed_vertical: Double?
    let is_ground: Bool?
  }
}

struct Departure: Codable {
  let airport : String?
  let timezone : String?
  let iata : String?
  let icao : String?
  let terminal : String?
  let gate : String?
  let delay : Int?
  let scheduled : Date?
  let estimated : Date?
  let actual : Date?
  let estimated_runway : String?
  let actual_runway : String?
  
  enum CodingKeys: String, CodingKey {

    case airport = "airport"
    case timezone = "timezone"
    case iata = "iata"
    case icao = "icao"
    case terminal = "terminal"
    case gate = "gate"
    case delay = "delay"
    case scheduled = "scheduled"
    case estimated = "estimated"
    case actual = "actual"
    case estimated_runway = "estimatedRunway"
    case actual_runway = "actualRunway"
  }
  
  var scheduledTimeString: String { dateToTimeString(scheduled) }
  var scheduledDateString: String { dateToDateString(scheduled) }
  var estimatedTimeString: String { dateToTimeString(estimated) }
  var estimatedDateString: String { dateToDateString(estimated) }
  var actualTimeString: String { dateToTimeString(actual) }
  var actualDateString: String { dateToDateString(actual) }
  
}

struct Arrival: Codable {
  let airport : String?
  let timezone : String?
  let iata : String?
  let icao : String?
  let terminal : String?
  let gate : String?
  let baggage : String?
  let delay : Int?
  let scheduled : Date?
  let estimated : Date?
  let actual : Date?
  let estimated_runway : String?
  let actual_runway : String?
  
  var scheduledTimeString: String { dateToTimeString(scheduled) }
  var scheduledDateString: String { dateToDateString(scheduled) }
  var estimatedTimeString: String { dateToTimeString(estimated) }
  var estimatedDateString: String { dateToDateString(estimated) }
  var actualTimeString: String { dateToTimeString(actual) }
  var actualDateString: String { dateToDateString(actual) }
  
  enum CodingKeys: String, CodingKey {

    case airport = "airport"
    case timezone = "timezone"
    case iata = "iata"
    case icao = "icao"
    case terminal = "terminal"
    case gate = "gate"
    case baggage = "baggage"
    case delay = "delay"
    case scheduled = "scheduled"
    case estimated = "estimated"
    case actual = "actual"
    case estimated_runway = "estimatedRunway"
    case actual_runway = "actualRunway"
  }
}

struct Airline: Codable {
  let name : String?
  let iata : String?
  let icao : String?
}

struct Flight: Codable {
  let number : String?
  let iata : String?
  let icao : String?
  let codeshared : Codeshared? = nil
  
  private enum CodingKeys: String, CodingKey {
    case number = "number"
    case iata = "iata"
    case icao = "icao"
  }
  
  struct Codeshared: Codable {
    let airline_name : String?
    let airline_iata : String?
    let airline_icao : String?
    let flight_number: String?
    let flight_iata : String?
    let flight_icao : String?
  }
}

private func dateToTimeString(_ date: Date?) -> String {
  if let date = date {
    let df = DateFormatter()
    df.dateFormat = "hh:mm a"
    
    return df.string(from: date)
  } else {
    return "--"
  }
}

private func dateToDateString(_ date: Date?) -> String {
  if let date = date {
    let df = DateFormatter()
    df.dateFormat = "E, MMM d"
    
    return df.string(from: date)
  } else {
    return "--"
  }
}
