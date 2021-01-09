//
//  ResizedImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct ResizedImageView: View {
    
    // MARK: - PROPERTIES
    
    @State private var iconSizes = IconSize.getSizes(set: .iOS)
    @State private var tempDirectory: String = ""
    
    @Binding var setOs: Int
    @Binding var originalImage: NSImage?
    @Binding var isOriginalImage: Bool
    
    // EFFICIENT GRID DEFINITION
    let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                ForEach(0 ..< iconSizes.count) { item in
                    VStack {
                        if isOriginalImage {
                            Image(nsImage: originalImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                                .cornerRadius(10.0)
                                .padding()
                        } else {
                            Image(systemName: "photo")
                                .font(.system(size: 50))
                                .frame(width: 80, height: 80, alignment: .center)
                            Text("iOS  20pt")
                                .font(.title3)
                        }
                    }
                }
                
            }
            
            Spacer()
            
            if isOriginalImage {
                Button(action: {
                    saveIconsToFolder()
                }) {
                    Text("Save icons")
                }
                .padding()
            }
        }
        
    }
    
    // MARK: - METHODS
    
    func loadIcons(_ forOS: Int) -> [IconSize] {
        
        switch forOS {
        case 0:
            print("Choose iOS")
            return IconSize.getSizes(set: .iOS)
        case 1:
            print("Choose macOS")
            return IconSize.getSizes(set: .macOS)
        case 2:
            print("Choose watchOS")
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
            for iconSize in loadIcons(setOs) {
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
        let temp = NSString(string: NSTemporaryDirectory()).appendingPathComponent("icon-resizer")
        
        
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
}
