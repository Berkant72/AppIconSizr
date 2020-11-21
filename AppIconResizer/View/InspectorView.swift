//
//  InspectorView.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

struct InspectorView: View {
    @State private var chooseIos: Bool = false
    @State private var chooseMacOs: Bool = false
    @State private var chooseWatchOs: Bool = false
    
    var body: some View {
        VStack {
            Text("Inspector")
                .modifier(PaneTitleModifier())
            VStack {
                Spacer()
                Text("Choose your icons!")
                VStack(alignment: .leading, spacing: 10) {
                    Toggle("iOS icons", isOn: $chooseIos)
                    Toggle("macOS icons", isOn: $chooseMacOs)
                    Toggle("watchOS icons", isOn: $chooseWatchOs)
                }
                Spacer()
            }
        } //: VSTACK
        .frame(minWidth: 200, idealWidth: 250, maxWidth: 250, minHeight: 150, idealHeight: 200, maxHeight: .infinity)
    }
}

struct InspectorView_Previews: PreviewProvider {
    static var previews: some View {
        InspectorView()
    }
}
