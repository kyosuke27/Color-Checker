//
//  BaseTextEditor.swift
//  Color-Checker
//
//  Created by kyosuke on 2026/03/11.
//

import SwiftUI

struct BaseTextEditor: View {
    @Binding var text:String
    var body: some View {
        TextEditor(text: $text)
    }
}

#Preview {
    @Previewable @State var text = "memo"
    BaseTextEditor(text: $text)
}
