//
//  SettingModalView.swift
//  MizutamaCollage
//
//  Created by Yuta on 2023/04/03.
//

import Foundation
import SwiftUI

struct SettingModalView: View{
    @State private var currentValueThreshold: Double = 0.75
    @State private var currentValueRadius: Double = 15
    @State private var currentValueSeed: Double = 0
    var body: some View {
        VStack{
            VStack {
                Text("身体範囲推定のしきい値：\(currentValueThreshold)")
                    .font(.largeTitle)
                
                Slider(value: $currentValueThreshold,
                       in: 0.3...0.95)      // 0から10の範囲を指定
            }.padding()
            VStack {
                Text("水玉の最小半径：\(currentValueRadius)")
                    .font(.largeTitle)
                
                Slider(value: $currentValueRadius,
                       in: 5...50)      // 0から10の範囲を指定
            }.padding()
            VStack {
                Text("乱数シード：\(currentValueSeed)")
                    .font(.largeTitle)
                
                Slider(value: $currentValueSeed,
                       in: 0...2048)      // 0から10の範囲を指定
            }.padding()
        }
    }
}
