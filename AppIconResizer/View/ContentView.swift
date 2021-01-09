//
//  ContentView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 15.11.20.
//

import SwiftUI

//enum OSIcons: Int, CaseIterable, Identifiable {
//
//    case iOS = 0
//    case macOS = 1
//    case watchOS = 2
//
//    var id: Int { self.rawValue }
//}

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @State private var setOs: Int = 0
    @State private var originalImage: NSImage?
    @State private var isOriginalImage: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            // MARK: ORIGINAL IMAGES
            VStack {
                
                Text("Original Image")
                    .modifier(PaneTitleModifier())
                
                Divider()
                Spacer()
                
                OriginalImageView(setOs: $setOs, originalImage: $originalImage, isOriginalImage: $isOriginalImage)
            }
            
            Divider()
            
            // MARK: RESIZED IMAGES
            VStack {
                Text("Resized Images")
                    .modifier(PaneTitleModifier())
                
                Divider()
                
                
                VStack {
                    Spacer()
                    
                    ResizedImageView(setOs: $setOs, originalImage: $originalImage, isOriginalImage: $isOriginalImage)
                    
                }
            } //: VSTACK
            .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity, minHeight: 150, idealHeight: 500, maxHeight: .infinity)
        } //: HSTACK
        .frame(minWidth: 800, idealWidth: 1000, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity, alignment: .center)
        .onAppear(perform: {
            //createNewDirectory()
        })
    } //: BODY
}
