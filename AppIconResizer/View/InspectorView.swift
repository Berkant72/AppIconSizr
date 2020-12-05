//
//  InspectorView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct InspectorView: View {
    
//    @Binding var chooseIos: Bool
//    @Binding var chooseMacOs: Bool
//    @Binding var chooseWatchOs: Bool
//    @State private var choose: Int = 1
//    let iconsFor = ["iOS", "macOS", "watchOS"]
    
//    var origImg: NSImageView!
//    var origLabel: NSTextField!
    
    
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
        VStack {
            Text("Inspector")
                .modifier(PaneTitleModifier())
            VStack {
                Spacer()
//                Text("Choose your icons!")
//                VStack(alignment: .leading, spacing: 10) {
//                    
//                    Picker("Icons for", selection: $choose) {
//                        ForEach(0 ..< iconsFor.count) { item in
//                            Text("\(iconsFor[item])")
//                        }
//                        
//                    }
//                    .padding()
//                    .pickerStyle(DefaultPickerStyle())
                    
                    
                    // with toggle
//                    Toggle("iOS icons", isOn: $chooseIos)
//                    Toggle("macOS icons", isOn: $chooseMacOs)
//                    Toggle("watchOS icons", isOn: $chooseWatchOs)
                }
                Spacer()
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
        } //: VSTACK
        .frame(minWidth: 200, idealWidth: 250, maxWidth: 250, minHeight: 150, idealHeight: 200, maxHeight: .infinity)
    }
}

struct InspectorView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}
