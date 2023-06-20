//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

import SwiftUI

struct CarouselView: View {
    let images: [Image] = [EventsOverviewImageAssets.example1.image, EventsOverviewImageAssets.example2.image]
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            images[currentIndex]
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            
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
