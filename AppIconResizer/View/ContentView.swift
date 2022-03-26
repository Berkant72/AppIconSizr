//
//  ContentView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 15.11.20.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var setOs: Int = 0
    @State private var originalImage: NSImage?
    @State private var isOriginalImage = false
    @State private var showResizedImage = false
    
    // MARK: - Body
    
    var originalImageView: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            Text("Original Image")
                .modifier(PaneTitleModifier())
            
            Divider()
            
            OriginalImageView(setOs: $setOs, originalImage: $originalImage, isOriginalImage: $isOriginalImage, showResizedImage: $showResizedImage)
            Spacer()
        }
        .frame(width: 300, height: 400)
//        .frame(minWidth: 200, idealWidth: 250, maxWidth: 300, minHeight: 150, idealHeight: 200, maxHeight: .infinity, alignment: .center)
    }
    
    var resizedImageView: some View {
        VStack {
            Text("Resized Images")
                .modifier(PaneTitleModifier())
            
            Divider()
            
            
            VStack {
                Spacer()
                
                ResizedImageView(setOs: $setOs, originalImage: $originalImage, isOriginalImage: $isOriginalImage, showResizedImage: $showResizedImage)
                
            }
        }
        .frame(minWidth: 500, idealWidth: 800, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity)
    }
    
    var body: some View {
        HStack {
            
            if !showResizedImage {
                originalImageView
            } else {
                resizedImageView
            }
        } 
//        .frame(minWidth: 1000, idealWidth: 1200, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity, alignment: .center)
//        .onAppear(perform: {
//            //createNewDirectory()
//        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
