//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {

    @Binding var isSheetPresented: Bool
    @ViewBuilder var content: () -> Content

    @State private var offset: CGFloat = .zero
    @State private var size: CGSize = .zero

    var body: some View {
        ZStack {
            if isSheetPresented {
                Color.black
                    .opacity(0.3)
                    .transition(.opacity)
                    .onTapGesture {
                        isSheetPresented.toggle()
                    }
            }
            VStack {
                Spacer()
                if isSheetPresented {
                    VStack(spacing: .zero) {
                        HStack {
                            Capsule()
                                .frame(width: 50, height: 5)
                                .foregroundColor(Color.gray)
                                .padding(.vertical)
                                .onTapGesture {
                                    isSheetPresented.toggle()
                                }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .background(Color.white)
                        content()
                    }
                    .saveSize(in: $size)
                    .transition(.move(edge: .bottom))
//                    .animation(.easeInOut(duration: 0.2))
                    .cornerRadius(20)
                }
            }
        }
        .ignoresSafeArea()
    }
}
