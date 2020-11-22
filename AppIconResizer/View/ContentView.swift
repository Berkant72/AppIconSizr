//
//  ContentView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 15.11.20.
//

import SwiftUI

struct ContentView: View {
    @State private var tempDirectory: String = ""
    
    var body: some View {
        HSplitView {
            OriginalImageView()
            ResizedImageView()
            InspectorView()
        }
        .onAppear(perform: {
            // create a temporary folder at launch
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
            
            
            
            
        })
        .frame(minWidth: 800, idealWidth: 1000, maxWidth: .infinity, minHeight: 600, idealHeight: 800, maxHeight: .infinity, alignment: .center)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
