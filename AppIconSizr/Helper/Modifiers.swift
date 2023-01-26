//
//  Modifiers.swift
//  AppIconSizr
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct PaneTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.accentColor)
            .padding()
    }
}

struct PlaceHolderImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 44))
            .foregroundColor(.gray)
            .padding(.vertical, 10)
    }
}
