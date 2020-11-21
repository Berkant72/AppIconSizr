//
//  ResizedImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct ResizedImageView: View {
    var body: some View {
        VStack {
            Text("Resized Images")
                .modifier(PaneTitleModifier())
                .frame(width: 200, height: 100, alignment: .center)
            VStack {
                Spacer()
                Text("Images")
                Spacer()
            }
        }
        .frame(minWidth: 400, idealWidth: 500, maxWidth: .infinity, minHeight: 150, idealHeight: 500, maxHeight: .infinity)
    }
}

struct ResizedImageView_Previews: PreviewProvider {
    static var previews: some View {
        ResizedImageView()
            .previewLayout(.fixed(width: 200, height: 150))
    }
}
