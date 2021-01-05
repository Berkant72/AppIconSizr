//
//  IconCellView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 06.12.20.
//

//import SwiftUI
//
//// Klasse für NSView, die anklickbar ist und als Drag&Drop-Source fungiert
//class IconCellView: NSView, NSDraggingSource {
//
//  var isize: IconSize!
//  var rtype: RetinaType!
//  var icon: NSImage!
//
//  // sonst wird mouseDragged nicht aufgerufen
//  override func mouseDown(with event: NSEvent) {
//  }
//
//  override func mouseDragged(with event: NSEvent) {
//    // kein Drag wenn keine Daten
//    if icon == nil  { return }
//
//    // Icon in temporären Verzeichnis speichern
//    let app = NSApplication.shared.delegate as! AppDelegate
//    let fname = isize.save(icon, type: rtype, folder: app.tempdir!)
//
//    //  Mausposition
//    let position = convert(event.locationInWindow, from: nil)
//
//    // NSURL-Objekt als Item übergeben
//    let url = NSURL(fileURLWithPath: fname)
//    let item = NSDraggingItem(pasteboardWriter: url)
//
//    item.imageComponentsProvider =
//      { // Closure, legt das während des Drag-Vorgangs
//        // anzuzeigende Bild fest
//        let component = NSDraggingImageComponent(key: .icon)
//        component.contents = self.icon
//
//        // 50x50 Vorschaubild mittig um aktuelle Mausposition
//        component.frame = NSRect(
//          origin: NSPoint(x: position.x-25, y: position.y-25),
//          size: NSSize(width: 50, height: 50))
//        return [component]
//    }
//
//    beginDraggingSession(with: [item], event: event, source: self)
//  }
//
//
//  // nur Copy erlauben
//  func draggingSession(_: NSDraggingSession,
//                       sourceOperationMaskFor _: NSDraggingContext)
//    -> NSDragOperation
//  {
//    return .copy
//  }
//
//  override func draggingEnded(_ sender: NSDraggingInfo) {
//    print("Dragging ended")
//  }
//}
