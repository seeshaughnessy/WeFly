//
//  View-Extension.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

extension View {
    func weFlyFont(style: UIFont.TextStyle) -> some View {
        self.modifier(WeFlyFontModifier(style: style))
    }
}


struct WeFlyFontModifier: ViewModifier {
    
    var style: UIFont.TextStyle = .body
//    var weight: Font.Weight = .regular
    
//    var textColor: Color {
//        switch style {
//        case .title1:
//            return .blue
//        case .caption1:
//            return Color.black.opacity(0.8)
//        default:
//            return .black
//        }
//    }

    func body(content: Content) -> some View {
        content
            .font(Font.custom("padauk-book", size: UIFont.preferredFont(forTextStyle: style).pointSize))
    }
    
}
