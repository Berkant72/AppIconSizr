//
//  OriginalImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct OriginalImageView: View {
    var body: some View {
        VStack {
            Text("Original Image")
                .modifier(PaneTitleModifier())
                
            VStack {
                Spacer()
                Text("Drag your original Image here!")
                    .font(.caption)
                Image(systemName: "photo")
                    .modifier(PlaceHolderImageModifier())
                Spacer()
            } //: VSTACK
            
        } //: VSTACK
        .frame(minWidth: 200, idealWidth: 250, maxWidth: 250, minHeight: 150, idealHeight: 200, maxHeight: .infinity)
    }
}

struct OriginalImageView_Previews: PreviewProvider {
    static var previews: some View {
        OriginalImageView()
            .previewLayout(.fixed(width: 200, height: 150))
    }
}
