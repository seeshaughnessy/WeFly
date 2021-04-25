//
//  Keyboard-Extension.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/18/21.
//

import SwiftUI

extension View {
  func hideKeyboard() {
    let resign = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
  }
}
