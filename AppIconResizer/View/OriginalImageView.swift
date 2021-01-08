//
//  OriginalImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct OriginalImageView: View {
    @Binding var isOriginalImage: Bool
    @Binding var originalImage: NSImage?
    @Binding var setOs: Int
    
//    @State private var iconsForiOS: Bool = true
//    @State private var iconsForMacOS: Bool = false
//    @State private var iconsForWatchOS: Bool = false
    
    let iconsFor = ["iOS", "macOS", "watchOS"]
    
    func getImageFromFinder() {
        
        let openPanel = NSOpenPanel()
        openPanel.worksWhenModal = true
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        openPanel.resolvesAliases = true
        openPanel.allowedFileTypes = ["png", "jpg", "jpeg", "PNG", "JPEG", "JPG"]
        
        if (openPanel.runModal() == NSApplication.ModalResponse.OK) {
            let result = openPanel.url
            if (result != nil) {
                let path: String = result!.path
                print(path)
                originalImage = NSImage(contentsOf: URL(fileURLWithPath: path))!
                
                isOriginalImage = true
            } else {
                // User clicked on cancel
                return
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                Button(action: {
                    getImageFromFinder()
                    
                }) {
                    Text("Click to add your original image here!")
                        .font(.caption)
                }
                Text("For best result use\nan image with 1024 x 1024 pt.")
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
                    PlacerHolderImageView()
                }
                
                Spacer()
                
                Text("Choose your icon set!")
                VStack(alignment: .leading, spacing: 10) {
                    
                    Picker("Icons for", selection: $setOs) {
                        ForEach(0 ..< iconsFor.count) { item in
                            Text("\(iconsFor[item])").tag(item)
                        }
                    }
                    .padding(.horizontal, 12)
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Spacer()
                } //: VSTACK
            } //: VSTACK
            
        } //: VSTACK
        .frame(minWidth: 200, idealWidth: 250, maxWidth: 250, minHeight: 150, idealHeight: 200, maxHeight: .infinity)
    }
}
