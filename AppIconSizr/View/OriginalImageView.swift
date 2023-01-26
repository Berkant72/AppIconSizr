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
    @State private var showChooseImageView = true
    
    @Binding var selectedOS: Int
    @Binding var originalImage: NSImage?
    @Binding var isOriginalImage: Bool
    @Binding var showResizedImage: Bool
    
    let devices = ["iOS", "macOS", "watchOS"]
    
    var originalImageView: some View {
        VStack {
            Button(action: {
                getImageFromFinder()
                
            }) {
                Text("Search for an image")
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Text("For best result use an image\nwith 1024 x 1024 pixels.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding()
            
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
            
            Picker("Devices", selection: $selectedOS) {
                ForEach(0..<devices.count, id: \.self) { item in
                    Text("\(devices[item])").tag(item)
                }
                let _ = print("Devices \(selectedOS)")
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .pickerStyle(.radioGroup)
            
            Spacer()
            
            Button("Choose new image!") {
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 1)) {
                    showChooseImageView = true
                    
                }
            }
            .buttonStyle(.borderedProminent)
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
        OriginalImageView(selectedOS: .constant(0), originalImage: .constant(NSImage(named: "AppIcon")), isOriginalImage: .constant(true), showResizedImage: .constant(false))
    }
}
