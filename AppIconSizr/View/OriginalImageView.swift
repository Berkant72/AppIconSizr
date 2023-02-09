//
//  OriginalImageView.swift
//  AppIconSizr
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct OriginalImageView: View {
    
    // MARK: - Properties
    
    @State private var iPhone: Bool = false
    @State private var mac: Bool = false
    @State private var appleWatch: Bool = false
    @State private var loadButton = true
    
    @Binding var selectedOS: Int
    @Binding var originalImage: NSImage?
    @Binding var isOriginalImage: Bool
    @Binding var showResizedImage: Bool
    
    let devices = ["iOS", "macOS", "watchOS"]
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            if loadButton {
                originalImageView
            } else {
                deviceView
            }
        }
    }
    
    var originalImageView: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("For best result use an icon with 1024 x 1024 pixels!")
                .font(.title2)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding()
            
            if #available(macOS 12.0, *) {
                Button {
                    getImageFromFinder()
                } label: {
                    Text("Load icon")
                        .foregroundColor(.white)
                    
                }
                .buttonStyle(.borderedProminent)
            } else {
                // Fallback on earlier versions
                Button {
                    getImageFromFinder()
                } label: {
                    Text("Load icon")
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    var deviceView: some View {
        VStack {
            Text("Choose your icon set!")
                .font(.body).bold()
            
            Picker("Devices", selection: $selectedOS) {
                ForEach(0..<devices.count, id: \.self) { item in
                    Text("\(devices[item])").tag(item)
                }
                // let _ = print("Devices \(selectedOS)")
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .pickerStyle(.radioGroup)
            
            Spacer()
        }
    }
    
    // MARK: - Methods
    
    func getImageFromFinder() {
        
        let openPanel = NSOpenPanel()
        openPanel.worksWhenModal = true
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        openPanel.resolvesAliases = true
        openPanel.allowedContentTypes = [.png, .jpeg]
        
        if (openPanel.runModal() == .OK) {
            let result = openPanel.url
            if (result?.pathExtension != "") {
                let path: String = result!.path
                
                originalImage = NSImage(contentsOf: URL(fileURLWithPath: path))!
                
                isOriginalImage = true
                loadButton = false
            } else {
                // User clicked on cancel
                loadButton = true
                return
            }
        }
    }
}

// MARK: - Previews

struct OriginalImageView_Previews: PreviewProvider {
    static var previews: some View {
        OriginalImageView(selectedOS: .constant(0), originalImage: .constant(NSImage(named: "AppIcon")), isOriginalImage: .constant(true), showResizedImage: .constant(false))
    }
}
