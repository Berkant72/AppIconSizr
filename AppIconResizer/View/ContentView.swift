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
    
    @State private var tempDirectory: String = ""
    @State private var iconSizes = IconSize.getSizes(set: .iOS)
    @State private var isOriginalImage: Bool = false
    @State private var setOs: Int = 0
    @State private var originalImage: NSImage?
//    @State private var iconsForiOS: Bool = true
//    @State private var iconsForMacOS: Bool = false
//    @State private var iconsForWatchOS: Bool = false
    
    //    var iconSize: IconSize!
    //    var retinaType: RetinaType!
    
    // EFFICIENT GRID DEFINITION
    let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var iconset = IconSet.iOS
//    let iconsFor = ["iOS", "macOS", "watchOS"]
    var imageView: NSImageView!
    var imageName: NSTextField!
    
    
    // Icon in voller Auflösung (linke Seite)
    var icon: NSImage! {
        didSet {
            imageView.image = icon
            imageName.stringValue = "\(Int(icon.size.width))x\(Int(icon.size.height))"
        }
    }
    
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
    
    
    // MARK: - METHODS
    
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
    
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 49/255, green: 39/255, blue: 176/255, opacity: 1), Color(red: 176/255, green: 233/255, blue: 86/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            
        HStack {
            // MARK: ORIGINAL IMAGES
            VStack {
                
                Text("Original Image")
                    .modifier(PaneTitleModifier())
                
                Divider()
                Spacer()
                
                OriginalImageView(isOriginalImage: $isOriginalImage, originalImage: $originalImage, setOs: $setOs)
            }
            
            Divider()
          
            // MARK: RESIZED IMAGES
            VStack {
                Text("Resized Images")
                    .modifier(PaneTitleModifier())
                
                Divider()
                
                
                VStack {
                    Spacer()
                    
                    
                    //                    if isOriginalImage {
                    
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
                    //                    }
                    
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
            .frame(minWidth: 400, idealWidth: 500, maxWidth: .infinity, minHeight: 150, idealHeight: 500, maxHeight: .infinity)
        } //: HSTACK
        .frame(minWidth: 800, idealWidth: 1000, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity, alignment: .center)
        .onAppear(perform: {
            createNewDirectory()
        })
    }
    } //: BODY
}
    
    
struct PlacerHolderImageView: View {
    var body: some View {
        Image("AppResizerIcon")
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)
        // .font(.system(size: 44))
    }
}



// MARK: - PREVIEW

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .previewLayout(.sizeThatFits)
//    }
//}
