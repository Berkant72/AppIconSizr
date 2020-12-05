//
//  ResizedImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct ResizedImageView: View {
   
    
//    @State private var chooseIos: Bool = true
//    @State private var chooseMacOs: Bool = false
//    @State private var chooseWatchOs: Bool = false
    
//    @State private var iconSizes = IconSize.getSizes(set: .iOS)
    
//    var origImg: NSImageView!
//    var origLabel: NSTextField!
//
//    // Icon in voller Auflösung (linke Seite)
//    var icon: NSImage! {
//        didSet {
//            origImg.image = icon
//            origLabel.stringValue = "\(Int(icon.size.width))x\(Int(icon.size.height))"
//
////            iconTable.reloadData ()
//
//        }
//    }
    
    var body: some View {
        Text("")
//        VStack {
//            Text("Resized Images")
//                .modifier(PaneTitleModifier())
//                .frame(width: 200, height: 100, alignment: .center)
//            VStack {
//                Spacer()
//
////                List(iconSizes, id: \.self) { item in
////                    Image(item)
////                }
//
//                Spacer()
//
//                Button(action: {
//                    // save the icons in folder
//                    print("Icons are ready to save in folder")
//
//                    let openFile = NSOpenPanel()
//                    openFile.title = "Verzeichnis zum Speichern der Icons"
//                    openFile.prompt = "Auswählen"
//                    openFile.worksWhenModal = true
//                    openFile.allowsMultipleSelection = false
//                    openFile.canChooseDirectories = true
//                    openFile.canChooseFiles = false
//                    openFile.canCreateDirectories = true
//                    openFile.resolvesAliases = true
//                    openFile.runModal()
//
//                    if let url = openFile.url {
//                        let folder = url.path
//                        for iconSize in iconSizes {
//                            if iconSize.x1 { _ = iconSize.save(icon, type: RetinaType.x1, folder: folder)
//                            }
//                            if iconSize.x2 { _ = iconSize.save(icon, type: RetinaType.x2, folder: folder)
//                            }
//                            if iconSize.x3 { _ = iconSize.save(icon, type: RetinaType.x3, folder: folder)
//
//                            }
//                        }
//                    }
//
//                }) {
//                    Text("Save icons!")
//                }
//                .padding()
//            }
//        }
//        .frame(minWidth: 400, idealWidth: 500, maxWidth: .infinity, minHeight: 150, idealHeight: 500, maxHeight: .infinity)
    }
}

struct ResizedImageView_Previews: PreviewProvider {
    static var previews: some View {
        ResizedImageView()
            .previewLayout(.fixed(width: 600, height: 450))
    }
}
