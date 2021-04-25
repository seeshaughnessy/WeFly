//
//  FlightResultsViewModel.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/14/21.
//

import SwiftUI
import CoreLocation
import MapKit

class FlightResultsViewModel: ObservableObject {
  
  @Published var flightResults: [FlightInfo]
  @Published var selectedFlight: FlightInfo?
  @Published var cities = [City]()
  @Published var airlines = [AirlineIata]()
  @Published var transitTime = ""
  @Published var autoTime = ""
  
  var locationManager = CLLocationManager()
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  
  init() {
    let flightJson: FlightJson = Bundle.main.decode("DemoSearchResults.json")
    self.flightResults = flightJson.data
    self.cities = Bundle.main.decode("AirportCities.json")
    self.airlines = Bundle.main.decode("AirlineCodes.json")
    setupManager()
  }
  
  func getCity(from iata: String?) -> String {
    let cities: [City] = Bundle.main.decode("AirportCities.json")
    
    guard let iata = iata else { return "--" }
    guard let cityIndex = cities.firstIndex(where: { $0.iata == iata }) else { return "--" }
    
    return cities[cityIndex].city
  }
  
  func getState(from iata: String?) -> String {
    let cities: [City] = Bundle.main.decode("AirportCities.json")
    
    guard let iata = iata else { return "--" }
    guard let cityIndex = cities.firstIndex(where: { $0.iata == iata }) else { return "--" }
    
    return cities[cityIndex].secondary
  }
  
  //MARK: - API GET flights
  
  func getFlightResults(with queries: [ApiQuery: String]) {
    let session = URLSession.shared
    var urlString = "http://api.aviationstack.com/v1/flights?limit=20&access_key=\(K.AVIATIONSTACK_API_KEY)"
    let url: URL
    
    queries.forEach { query in
      if !query.value.isEmpty {
        urlString += "&\(query.key.rawValue)=\(query.value)"
      }
    }
    
    url = URL(string: urlString)!
    
    let task = session.dataTask(with: url) { data, response, error in
      
      if error != nil || data == nil {
        print("Client error!")
        return
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Server error!")
        return
      }
      
      guard let mime = response.mimeType, mime == "application/json" else {
        print("Wrong MIME type!")
        return
      }
      
      let flightJson: FlightJson = self.parseJSON(data!)
      
      DispatchQueue.main.async {
        self.flightResults = flightJson.data
        //        print("Flight results updated: \(self.flightResults)")
      }
      
    }
    
    task.resume()
  }
  
  //MARK: - Parse JSON
  
  private func parseJSON(_ data: Data) -> FlightJson {
    
    let decoder = JSONDecoder()
    
    // Format Dates
    decoder.dateDecodingStrategy = .iso8601
    
    guard let loaded = try? decoder.decode(FlightJson.self, from: data) else {
      fatalError("Failed to decode \(data) from JSON.")
    }
    
    return loaded
  }
  
  //MARK: - DATE timer and label formatting
  
  func dateToTimeString(_ date: Date?) -> String {
    if let date = date {
      let df = DateFormatter()
      df.dateFormat = "hh:mm a"
      
      return df.string(from: date)
    } else {
      return "--"
    }
  }
  
  func dateToDateString(_ date: Date?) -> String {
    if let date = date {
      let df = DateFormatter()
      df.dateFormat = "YYYY-MM-DD"
      
      return df.string(from: date)
    } else {
      return "--"
    }
  }
  
  func countdown(to time: Date?, offset: TimeOffset) -> String {
    guard let time = time else { return "--" }
    
    let adjustedTime = Calendar.current.date(byAdding: .minute, value: -offset.rawValue, to: time)
    
    let difference = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: adjustedTime ?? time)
    
    var formattedString = ""
    
    if difference.day! != 0 {
      if difference.day! < 0 { formattedString += "-"}
      formattedString += "\(abs(difference.day!))d"
    } else if difference.hour! != 0 {
      if difference.hour! < 0 { formattedString += "-"}
      formattedString += "\(abs(difference.hour!))h \(abs(difference.minute!))m"
    } else {
      if difference.minute! < 0 { formattedString += "-"}
      formattedString += "\(abs(difference.minute!))m"
    }
    
    return formattedString
  }
  
  func countdownColor(to time: Date?, offset: TimeOffset) -> Color {
    guard let time = time else { return Color.greenWeFly }
    
    let adjustedTime = Calendar.current.date(byAdding: .minute, value: -offset.rawValue, to: time)
    
    let difference = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: adjustedTime ?? time)
    
    if difference.day! <= 0 && difference.hour! <= 0 {
      if difference.minute! <= 0 {
        return Color.red
      } else {
        return Color.orangeWeFly
      }
      
    } else {
      return Color.greenWeFly
    }
  }
  
  func countdownInMinutes(with offset: TimeOffset) -> Double {
    guard let time = selectedFlight?.departure.estimated else { return 0.0 }
    
    let adjustedTime = Calendar.current.date(byAdding: .minute, value: -offset.rawValue, to: time)
    
    let difference = Calendar.current.dateComponents([.minute], from: Date(), to: adjustedTime ?? time)
    
    return Double(difference.minute ?? 0)
  }
  
  //MARK: - LOCATIONS
  
  func getTransitTime(with flight: FlightInfo) {
    guard let airport = flight.departure.airport else { return }
    let city = getCity(from: flight.departure.iata)
    let state = getState(from: flight.departure.iata)
    
    let address = "\(airport), \(city), \(state)"
    
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(address) { (placemarks, error) in
      guard
        let placemarks = placemarks,
        let location = placemarks.first?.location
      else {
        // handle no location found
        return
      }
      
      //      print("Airport Coords: \(location.coordinate)")
      
      // Get automibile transit time
      self.requestETA(destination: location.coordinate, transitType: .automobile) { (travelTime, error) in
        //Get time remaining string
        guard let travelTime = travelTime, error == nil else {
          print("Could not find travel time")
          return
        }
          self.autoTime = travelTime
      }
      
      //Get public transit time
      self.requestETA(destination: location.coordinate, transitType: .transit) { (travelTime, error) in
        //Get time remaining string
        guard let travelTime = travelTime, error == nil else {
          print("Could not find travel time")
          return
        }
          self.transitTime = travelTime
      }
      
      return
    }
    
  }
  
  
  private func requestETA(destination: CLLocationCoordinate2D, transitType: MKDirectionsTransportType, completion: @escaping (_ string: String?, _ error: Error?) -> ()) {
    let lat = locationManager.location?.coordinate.latitude ?? 0
    let lon = locationManager.location?.coordinate.longitude ?? 0
    
    let currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    print(currentLocation)
    
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
    request.transportType = transitType
    
    // code setting up directions request
    let directions = MKDirections(request: request)
    
    print(directions)
    var travelTime: String?
    directions.calculate { response, error in
      if let route = response?.routes.first {
        travelTime = route.expectedTravelTime.stringFormatted()
      }
      completion(travelTime, error)
    }
  }
  
}
