//
//  TimeInterval-Extension.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/20/21.
//

import Foundation

extension TimeInterval {
    // builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
      var miliseconds = self.rounded(.up)
        miliseconds = miliseconds.truncatingRemainder(dividingBy: 10)
        let interval = Int(self)
//        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
      
      var formattedString = ""

      if hours > 0 {
        formattedString = "\(hours)h \(minutes)m"
      } else {
        formattedString = "\(minutes)m"
      }
        
        return formattedString
    }
}
