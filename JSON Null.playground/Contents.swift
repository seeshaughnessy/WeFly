import SwiftUI

//struct Student: Codable {
//    let name: String?
//    let amount: Double?
//    let adress: String?
//}
//
//let okData = """
//{
//   "name": "here",
// "amount": 100.0,
// "adress": "woodpecker avenue 1"
//}
//""".data(using: .utf8)!
//
let decoder = JSONDecoder()
//let okStudent = try decoder.decode(Student.self, from:okData)
//print(okStudent)
//
//let nullData = """
//{
//   "name": "there",
// "amount": null,
//"adress": "grassland 2"
//}
//""".data(using: .utf8)!
//
//let nullStudent = try decoder.decode(Student.self, from:nullData)
//print(nullStudent)

//Dates
let hourOffset = 13

struct Spaceship : Codable {
    var name: String
    var createdAt: Date
}
let jsonShipA = """
{
    "name": "Skyhopper",
    "createdAt": "2021-04-18T08:00:00+00:00"
}
"""

decoder.dateDecodingStrategy = .iso8601
let dataA = jsonShipA.data(using: .utf8)!
if let decodedShip = try? decoder.decode(Spaceship.self, from: dataA) {
    print("jsonShipA date = \(decodedShip.createdAt)")
  print(countdown(to: decodedShip.createdAt, hourOffset: hourOffset))
  
} else {
    print("Failed to decode iso8601 date format from jsonShipA")
}
func countdown(to time: Date?, hourOffset: Int = 0, minOffset: Int = 0) -> String {
  guard let time = time else { return "--" }
  
  let timeHoursAdjusted = Calendar.current.date(byAdding: .hour, value: -hourOffset, to: time)
  let adjustedTime = Calendar.current.date(byAdding: .minute, value: -minOffset, to: timeHoursAdjusted ?? time)
  
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

extension TimeInterval {
    // builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
      var miliseconds = self.rounded(.up)
        miliseconds = miliseconds.truncatingRemainder(dividingBy: 10)
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d.%.f", minutes, seconds, miliseconds)
    }
}

1023.32.stringFormatted()


