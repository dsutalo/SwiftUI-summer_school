//
//  Design.swift
//  Challenge3
//
//  Created by Domagoj Sutalo on 25.09.2021..
//

import Foundation
import SwiftUI



struct ButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .background(Color.blue.opacity(0.7))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .font(.title)
    }
}

struct NewGameButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .background(Color.orange.opacity(0.7))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .font(.title)
    }
}

extension View {
    func buttonDesign() -> some View {
        self.modifier(ButtonDesign())
    }
    
    func newGameDesign() -> some View {
        self.modifier(NewGameButtonDesign())
    }
}
