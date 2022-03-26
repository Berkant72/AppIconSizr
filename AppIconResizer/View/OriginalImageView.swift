//
//  OriginalImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct OriginalImageView: View {
    
    // MARK: - Properties
    
    @State private var iPhone: Bool = false
    @State private var iPad: Bool = false
    @State private var mac: Bool = false
    @State private var appleWatch: Bool = false
    @State private var showChooseImageView = true
    
    @Binding var setOs: Int
    @Binding var originalImage: NSImage?
    @Binding var isOriginalImage: Bool
    @Binding var showResizedImage: Bool
    
    let iconsFor = ["iOS", "iPadOS", "macOS", "watchOS"]
    
    var originalImageView: some View {
        VStack {
            Button(action: {
                getImageFromFinder()
                
            }) {
                Text("Click to add your original image here!")
                    .font(.caption)
            }
            Text("For best result use an image\nwith 1024 x 1024 pixels.")
                .font(.footnote)
                .foregroundColor(.secondary)
            
            if isOriginalImage {
                Image(nsImage: originalImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(10.0)
                    .padding()
            } else {
                PlaceholderImageView()
            }
        }
    }
    
    var deviceView: some View {
        VStack {
            Text("Choose your icon set!")
                .font(.body).bold()
            
            Picker("Devices", selection: $setOs) {
                ForEach(0 ..< iconsFor.count) { item in
                    Text("\(iconsFor[item])").tag(item)
                }
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .pickerStyle(.radioGroup)
            
            Spacer()
            
            Button("Resize images!") {
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 1)) {
                    showResizedImage = true
                    showChooseImageView = false
                }
                
            }
            
            Button("Choose new image!") {
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 1)) {
                    showChooseImageView = true
                    //                showChooseIconSetView = false
                }
                
            }
        }
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 1)) {
                //
            }
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            if showChooseImageView {
                originalImageView
            } else {
                deviceView
            }
        }
        //        .onAppear {
        //            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.5, blendDuration: 1)) {
        //                showChooseImageView = true
        //            }
        //        }
        
    }
    
    // MARK: - Methods
    
    func getImageFromFinder() {
        
        let openPanel = NSOpenPanel()
        openPanel.worksWhenModal = true
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        openPanel.resolvesAliases = true
        //        openPanel.allowedFileTypes = ["png", "jpg", "jpeg", "PNG", "JPEG", "JPG"]
        openPanel.allowedContentTypes = [.png, .jpeg]
        
        if (openPanel.runModal() == NSApplication.ModalResponse.OK) {
            let result = openPanel.url
            if (result != nil) {
                let path: String = result!.path
                print(path)
                originalImage = NSImage(contentsOf: URL(fileURLWithPath: path))!
                
                isOriginalImage = true
                showChooseImageView = false
            } else {
                // User clicked on cancel
                showChooseImageView = true
                return
            }
        }
    }
}

struct OriginalImageView_Previews: PreviewProvider {
    static var previews: some View {
        OriginalImageView(setOs: .constant(1), originalImage: .constant(NSImage(named: "AppIcon")), isOriginalImage: .constant(true), showResizedImage: .constant(false))
    }
}
