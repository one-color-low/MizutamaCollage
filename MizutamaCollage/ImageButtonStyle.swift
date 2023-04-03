//
//  ImageButtonStyle.swift
//  MizutamaCollage
//
//  Created by Yuta on 2023/04/03.
//

import Foundation
import SwiftUI

struct ImageButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .border( configuration.isPressed ? Color.blue : Color.clear )
    }
}
