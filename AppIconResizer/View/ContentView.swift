//
//  ContentView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 15.11.20.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var selectedOS: Int = 0
    @State private var originalImage: NSImage?
    @State private var isOriginalImage = false
    @State private var showResizedImage = false
    
    // MARK: - Body
    
    var originalImageView: some View {
        
        VStack(spacing: 20) {
            
            Text("Original Image")
                .modifier(PaneTitleModifier())
            
            Divider()
            
            OriginalImageView(selectedOS: $selectedOS, originalImage: $originalImage, isOriginalImage: $isOriginalImage, showResizedImage: $showResizedImage)
            
            Spacer()
        }
        .frame(width: 300)
    }
    
    var resizedImageView: some View {
        VStack(spacing: 20) {
            Text("Resized Images")
                .modifier(PaneTitleModifier())
            
            Divider()
            
            
            VStack {
                Spacer()
                
                ResizedImageView(selectedOS: $selectedOS, originalImage: $originalImage, isOriginalImage: $isOriginalImage, showResizedImage: $showResizedImage)
                
                Spacer()
            }
        }
        .frame(minWidth: 500, idealWidth: 800, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity)
    }
    
    var body: some View {
        if #available(macOS 13.0, *) {
            NavigationSplitView {
                // Sidebar
                List {
                    Text("Latest icons")
                }
            } content: {
                // Content
                originalImageView
            } detail: {
                // Detail
                resizedImageView
            }
            .frame(minWidth: 800, idealWidth: 1000, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity)
        } else {
            // Fallback on earlier versions
            HStack {
                originalImageView
                Divider()
                resizedImageView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
