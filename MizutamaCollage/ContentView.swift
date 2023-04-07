//
//  ContentView.swift
//  MizutamaCollage
//
//  Created by Yuta on 2023/04/03.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let videoCapture = VideoCapture()
    @State var image: UIImage? = nil
    @State var isRunningCamera = false
    @State var showingSettingModal = false
    var body: some View {
        
        VStack(alignment: .center) {
            
            if isRunningCamera{
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 400)
                        .border(Color.blue, width: 2)
                }else{
                    // 画像が無い場合
                    Text("画像が取得できません。カメラのプライバシー設定を確認してください。")
                        .padding()
                        .frame(width: 200, height: 400)
                        .border(Color.blue, width: 2)
                }
                
            }else{
                // 撮影が開始されていない場合
                Text("撮影を開始するには「○」ボタンをタップします。")
                    .padding() // .frameの前にある必要あり
                    .frame(width: 200, height: 400)
                    .border(Color.blue, width: 2)
            }
            
            
            HStack(alignment: .center) {
                
                // 3分割した領域を作成
                // その領域に各種ボタンを配置
                
                // 左
                Button(
                    action: {
                        print("album button tapped.")
                    },
                    label: {
                        if !isRunningCamera{
                            if let image = image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }else{
                                // 初期状態
                                Image(systemName: "rectangle.portrait.fill")
                                    .font(.system(size: 50))
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(Color.black)
                            }
                        }else{
                            Image(systemName: "rectangle.portrait.fill")
                                .font(.system(size: 50))
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.black)
                        }
                    }
                )
                .frame(width: 120, alignment: .center)
                
                // 中央
                
                Button(
                    action: {
                        isRunningCamera = true
                        videoCapture.run { sampleBuffer in
                            if let convertImage = UIImageFromSampleBuffer(sampleBuffer) {
                                DispatchQueue.main.async {
                                    self.image = convertImage
                                }
                            }
                        }
                    },
                    label: {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                            .frame(alignment: .center)
                    }
                )
                .buttonStyle(AnimationButtonStyle())
                .frame(width: 120, alignment: .center)
                
                // 右
                Button(
                    action: {
                        showingSettingModal = true
                        print("setting button tapped.")
                    },
                    label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 50))
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.white)
                            .frame(alignment: .center)
                    }
                )
                .frame(width: 120, alignment: .center)
                
            }
            .background(Color.gray)
            .frame(height: 100, alignment: .center)
            
        }
        
        .sheet(isPresented: $showingSettingModal) {
            SettingModalView()
        }
    }
    
    func UIImageFromSampleBuffer(_ sampleBuffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            let context = CIContext()
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image)
            }
        }
        return nil
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
