//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

import SwiftUI

struct CarouselView: View {
    let images: [Image] = [EventsOverviewImageAssets.sample1.image,
                           EventsOverviewImageAssets.sample2.image,
                           EventsOverviewImageAssets.sample3.image]
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            ForEach(images.indices, id: \.self) { index in
                images[currentIndex]
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 400)
                    .offset(x: CGFloat(index - currentIndex) * UIScreen.main.bounds.width, y: 0)
                    .animation(.easeInOut)
                    .onTapGesture {
                        print("image \(currentIndex) tapped")
                        print("image \(index) tapped")
                    }
            }
//            ForEach(0..<images.count) { index in
//                images[currentIndex]
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 400)
//                    .offset(x: CGFloat(index - currentIndex) * UIScreen.main.bounds.width, y: 0)
//                    .animation(.easeInOut)
//                    .onTapGesture {
//                        print("image \(currentIndex) tapped")
//                    }
//            }
            
            HStack(spacing: 10) {
                ForEach(0..<images.count) { index in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(index == currentIndex ? .blue : .gray)
                        .onTapGesture {
                            currentIndex = index
                            resetTimer()
                        }
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % images.count
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func resetTimer() {
        stopTimer()
        startTimer()
    }
}
