//
//  AnimationButtonStyle.swift
//  MizutamaCollage
//
//  Created by Yuta on 2023/04/05.
//

import Foundation
import SwiftUI

struct AnimationButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.red : Color.black)
            .scaleEffect(configuration.isPressed ? 3.0 : 2.0)
            .animation(.easeOut(duration: 1.0), value: configuration.isPressed)
    }
}
