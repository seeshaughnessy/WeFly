//
//  TextFieldView.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

struct TextFieldView: View {
  
  //MARK: - PROPERTIES
  let symbol: String
  let placeholder: String
  
  @Binding var input: String
  
  //MARK: - BODY
  
    var body: some View {
      HStack(spacing: 0) {
        Image(systemName: symbol)
          .font(.title)
          .frame(width: 50, height: 50, alignment: .leading)
        
        TextField(placeholder, text: $input)
          .padding(15)
          .background(Color.darkGrayWeFly)
          .cornerRadius(10)
      }
      .foregroundColor(input != "" ? .white : .lightGrayWeFly)
    }
}

//MARK: - PREVIEW

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
      TextFieldView(symbol: "paperplane.circle", placeholder: "Airport", input: .constant("BA452"))
    }
}
