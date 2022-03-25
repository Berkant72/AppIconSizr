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
    
    // MARK: - Properties
    
    @State private var setOs: Int = 0
    @State private var originalImage: NSImage?
    @State private var isOriginalImage: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            // MARK: Original images
            VStack {
                
                Text("Original Image")
                    .modifier(PaneTitleModifier())
                
                Divider()
                Spacer()
                
                OriginalImageView(setOs: $setOs, originalImage: $originalImage, isOriginalImage: $isOriginalImage)
            }
            .frame(minWidth: 200, idealWidth: 250, maxWidth: 300, minHeight: 150, idealHeight: 200, maxHeight: .infinity)
            
            Divider()
            
            // MARK: Resized images
            VStack {
                Text("Resized Images")
                    .modifier(PaneTitleModifier())
                
                Divider()
                
                
                VStack {
                    Spacer()
                    
                    ResizedImageView(setOs: $setOs, originalImage: $originalImage, isOriginalImage: $isOriginalImage)
                    
                }
            }
            .frame(minWidth: 600, idealWidth: 800, maxWidth: .infinity, minHeight: 150, idealHeight: 500, maxHeight: .infinity)
        } 
        .frame(minWidth: 1000, idealWidth: 1200, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity, alignment: .center)
        .onAppear(perform: {
            //createNewDirectory()
        })
    }
}
