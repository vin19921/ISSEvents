//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    let defaultPadding: CGFloat
    let cellBorderWidth: CGFloat
    let isSinglePage: Bool

    init(pageCount: Int,
         currentIndex: Binding<Int>,
         defaultPadding: CGFloat,
         cellBorderWidth: CGFloat,
         isSinglePage: Bool,
         @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        _currentIndex = currentIndex
        self.defaultPadding = defaultPadding
        self.cellBorderWidth = cellBorderWidth
        self.isSinglePage = isSinglePage
        self.content = content()
    }

    @GestureState private var translation: CGFloat = 0
    @State private var timer: Timer? = nil

    var body: some View {
        GeometryReader { geometry in
            HStack {
                content
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: paddingX(geometry: geometry))
            .offset(x: translation)
            .animation(.interactiveSpring(), value: currentIndex)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating($translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / (geometry.size.width - defaultPadding * 2)
                    let newIndex = (CGFloat(currentIndex) - offset).rounded()
                    currentIndex = min(max(Int(newIndex), 0), pageCount - 1)
                    resetTimer()
                }
            )
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }

    private func paddingX(geometry: GeometryProxy) -> CGFloat {
        let itemWidth = geometry.size.width
        let leadingPadding = defaultPadding

        guard currentIndex >= 0 && currentIndex < pageCount else {
            return 0
        }

        switch currentIndex {
        case 0:
            return defaultPadding
        default:
            return -(CGFloat(currentIndex) * itemWidth - (defaultPadding * CGFloat(currentIndex+1)) - CGFloat(currentIndex) * (leadingPadding / 2))
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % pageCount
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        startTimer()
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

}

