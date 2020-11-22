//
//  OriginalImageView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct OriginalImageView: View {
    
    var isize: IconSize!
    var rtype: RetinaType!
    @State private var icon: NSImage!
    @State private var showImage: Bool = false
    
    var body: some View {
        VStack {
            Text("Original Image")
                .modifier(PaneTitleModifier())
                
            VStack {
                Spacer()
                
                Button(action: {
                    // TODO
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
                            icon = NSImage(contentsOf: URL(fileURLWithPath: path))
                           
                            showImage = true
                        } else {
                            // User clicked on cancel
                            return
                        }
                    }

                }) {

                    Text("Click to add your original Image here!")
                        .font(.caption)

                }
                
                if showImage {
                    Image(nsImage: icon)
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
            } //: VSTACK
            
        } //: VSTACK
        .frame(minWidth: 200, idealWidth: 250, maxWidth: 250, minHeight: 150, idealHeight: 200, maxHeight: .infinity)
        
    }
}

struct OriginalImageView_Previews: PreviewProvider {
    static var previews: some View {
        OriginalImageView()
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
