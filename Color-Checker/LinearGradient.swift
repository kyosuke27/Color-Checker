//
//  LinearGradient.swift
//  Color-Checker
//
//  Created by kyosuke on 2026/02/01.
//

import SwiftUI

struct LinearGradient: View {
    let text:String
    var body: some View {
        HStack{
            Text(text)
        }
    }
}

#Preview {
    LinearGradient(text: "R")
    LinearGradient(text: "G")
}
