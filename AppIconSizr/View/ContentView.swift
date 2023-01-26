//
//  ContentView.swift
//  AppIconSizr
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
    
    @State private var tempDirectory: String = ""
    
    
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
        .frame(minWidth: 500, idealWidth: 1000, maxWidth: .infinity, minHeight: 600, idealHeight: 1200, maxHeight: .infinity)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [ Color.indigo.opacity(0.8), Color.purple.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                .toolbar {
                    if isOriginalImage {
                        Button("Export") { saveIconsToFolder() }
                    }
                    Button("New image") { getImageFromFinder() }
                }
                .frame(minWidth: 800, idealWidth: 1000, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity)
                
            } else {
                // Fallback on earlier versions
                HStack {
                    originalImageView
                    Divider()
                    resizedImageView
                }
                .toolbar {
                    if isOriginalImage {
                        Button("Export") { saveIconsToFolder() }
                    }
                    
                    
                }
            }
        }
        
    }
    
    // MARK: - Methods
    
    func loadIcons(_ forOS: Int) -> [IconSize] {
        
        switch forOS {
        case 0:
            return IconSize.getSizes(set: .iOS)
        case 1:
            return IconSize.getSizes(set: .macOS)
        case 2:
            return IconSize.getSizes(set: .watchOS)
        default:
            return IconSize.getSizes(set: .iOS)
        }
    }
    
    func saveIconsToFolder() {
        // save the icons in folder
        print("Icons are ready to save in folder")
        
        let openFile = NSOpenPanel()
        openFile.title = "Verzeichnis zum Speichern der Icons"
        openFile.prompt = "Auswählen"
        openFile.worksWhenModal = true
        openFile.allowsMultipleSelection = false
        openFile.canChooseDirectories = true
        openFile.canChooseFiles = false
        openFile.canCreateDirectories = true
        openFile.resolvesAliases = true
        openFile.runModal()
        
        if let url = openFile.url {
            let folder = url.path
            for iconSize in loadIcons(selectedOS) {
                if iconSize.x1 { _ = iconSize.save(originalImage!, type: RetinaType.x1, folder: folder)
                }
                if iconSize.x2 { _ = iconSize.save(originalImage!, type: RetinaType.x2, folder: folder)
                }
                if iconSize.x3 { _ = iconSize.save(originalImage!, type: RetinaType.x3, folder: folder)
                }
            }
            
            // show the folder where images were saved
            NSWorkspace.shared.activateFileViewerSelecting( [url] )
        }
    }
    
    func createNewDirectory() {
        // create a temporary directory at launch
        let fileManager = FileManager.default
        
        // subfolder for resized icons in temporary directorry
        let temp = NSString(string: NSTemporaryDirectory()).appendingPathComponent("appiconsizr")
        
        
        do {
            // delete if directory is existing
            if fileManager.fileExists(atPath: temp)
            {
                try fileManager.removeItem(atPath: temp)
            }
            
            // create a new directory
            try fileManager.createDirectory(atPath: temp, withIntermediateDirectories: false, attributes: nil)
            
            tempDirectory = temp
        } catch _ {
            // if error use temporary directory
            tempDirectory = NSTemporaryDirectory()
        }
    }
    
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
                
                // isOriginalImage = true
                // showChooseImageView = false
            } else {
                // User clicked on cancel
                // showChooseImageView = true
                return
            }
            
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
