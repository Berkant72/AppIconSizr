//
//  AppIconSizrApp.swift
//  AppIconSizr
//
//  Created by Berkant Dursun on 15.11.20.
//

import SwiftUI

@main
struct AppIconSizrApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onDisappear(perform: {
                    NSApplication.shared.terminate(self)
                })
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About App Icon Sizr") {
                    NSApplication.shared.orderFrontStandardAboutPanel(
                        options: [
                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                string: "Resize your custom app icons for iOS, macOS and watchOS to add them into Xcode's Assets catalog.",
                                attributes: [
                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
                                        ofSize: NSFont.smallSystemFontSize)
                                ]
                            ),
                            NSApplication.AboutPanelOptionKey(rawValue: "Copyright"): "© 2020 BERKANT DURSUN"]
                    )
                }
            }
        }
    }
}
