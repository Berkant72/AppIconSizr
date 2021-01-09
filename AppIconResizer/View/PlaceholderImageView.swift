//
//  PlaceholderImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 08.01.21.
//

import SwiftUI

struct PlaceholderImageView: View {
    var body: some View {
        Image("AppResizerIcon")
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)
        // .font(.system(size: 44))
    }
}

