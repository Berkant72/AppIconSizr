//
//  ContentView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 15.11.20.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @State private var tempDirectory: String = ""
    @State private var iconSizes = IconSize.getSizes(set: .iOS)
    @State private var isOriginalImage: Bool = false
    @State private var choose: Int = 0
    @State private var originalImage: NSImage?
    
    // EFFICIENT GRID DEFINITION
    let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var iconSize: IconSize?
    
//    var iconSize: IconSize!
//    var rtype: RetinaType!
    var iconset = IconSet.iOS
    let iconsFor = ["iOS", "macOS", "watchOS"]
    var origImg: NSImageView!
    var origLabel: NSTextField!
    
    
    // Icon in voller Auflösung (linke Seite)
    var icon: NSImage! {
        didSet {
            origImg.image = icon
            origLabel.stringValue = "\(Int(icon.size.width))x\(Int(icon.size.height))"
            
            //            iconTable.reloadData ()
            
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
            for iconSize in iconSizes {
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
    
//    // Icon mit Beschriftung erzeugen
//    private func makeLabeledIcon(_ offset: CGFloat,
//                                 _ width: CGFloat,
//                                 _ isize: IconSize,
//                                 _ rtype: RetinaType,
//                                 _ txt: String) -> NSView
//    {
//      let rect = CGRect(x: offset, y: 0,
//                        width: width, height: cellheight)
//      let iconview = IconCellView(frame: rect)
//      // IconCellView-spezifische Eigenschaften
//      iconview.isize = isize
//      iconview.rtype = rtype
//      iconview.icon = icon
//
//      // Textfeld zur Beschriftung
//      let txtrect = CGRect(x: 0, y: 0, width: width, height: 20)
//      let lbl = NSTextField(frame: txtrect)
//      lbl.stringValue = txt
//      lbl.alignment = .center
//      lbl.isEditable = false
//      lbl.isBezeled = false
//      lbl.drawsBackground = false
//      iconview.addSubview(lbl)
//
//      // Image-View mit Icon
//      let side = cellheight - 30 // Icon-Größe
//      let iconrect = CGRect(x: (width-side) / 2, y: 25,
//                            width: side, height: side)
//      let img = NSImageView(frame: iconrect)
//      img.image = icon ?? NSImage(named: NSImage.Name(rawValue: "file_question"))
//      iconview.addSubview(img)
//      return iconview
//    }
    
    // MARK: - BODY
    
    var body: some View {
        
        HStack {
            // ORIGINAL IMAGES
            VStack {
                
                Text("Original Image")
                    .modifier(PaneTitleModifier())
                    
                Divider()
                Spacer()
                
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    
                    Button(action: {
                        getImageFromFinder()
                        
                    }) {
                        Text("Click to add your original Image here!")
                            .font(.caption)
                        
                    }
                    
                    if isOriginalImage {
                        Image(nsImage: originalImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(10.0)
                            .padding()
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 44))
                    }
                    
                    Spacer()
                    
                    Text("Choose your icons!")
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Picker("Icons for", selection: $choose) {
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
            
            Divider()
            
            // RESIZED IMAGES
            VStack {
                Text("Resized Images")
                    .modifier(PaneTitleModifier())
                    
                Divider()
                
                
                VStack {
                    Spacer()
                    
                                    
//                    if isOriginalImage {
                        
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(0 ..< 12) { item in
                                Image(systemName: "photo")
                                    .font(.system(size: 100))
                                    .frame(width: 100, height: 100, alignment: .center)
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
    } //: BODY
    
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
