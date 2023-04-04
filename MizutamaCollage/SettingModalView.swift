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
    @State private var hiddenWay: Int = 0
    @State private var selectedColor = Color.blue
    var body: some View {
        VStack{
            
            VStack {
                Text("身体範囲推定のしきい値：\(currentValueThreshold, specifier: "%.2f")")
                    .font(.headline)
                
                Slider(value: $currentValueThreshold,
                       in: 0.3...0.95,
                       step: 0.01,
                       minimumValueLabel: Text("0.3"),
                       maximumValueLabel: Text("0.95"),
                       label: { EmptyView() })      // 0から10の範囲を指定
                
            }.padding()
            
            VStack {
                Text("水玉の最小半径：\(currentValueRadius, specifier: "%.0f")")
                    .font(.headline)
                
                Slider(value: $currentValueRadius,
                       in: 5...50,
                       step: 1,
                       minimumValueLabel: Text("5"),
                       maximumValueLabel: Text("50"),
                       label: { EmptyView() })      // 0から10の範囲を指定
                
            }.padding()
            
            VStack {
                Text("乱数シード：\(currentValueSeed, specifier: "%.0f")")
                    .font(.headline)
                
                Slider(value: $currentValueSeed,
                       in: 0...2048,
                       step: 1,
                       minimumValueLabel: Text("0"),
                       maximumValueLabel: Text("2048"),
                       label: { EmptyView() })      // 0から10の範囲を指定
                
            }.padding()
            
            VStack{
                Text("隠し方")
                    .font(.headline)
                Picker("", selection: $hiddenWay) {
                            Text("固定色").tag(0)
                            Text("固定肌色+すりガラス").tag(1)
                            Text("inpaint+すりガラス").tag(2)
                        }
            }.padding()
            
            VStack{
                ColorPicker("固定色", selection : $selectedColor)
            }.padding()
        }
    }
}
