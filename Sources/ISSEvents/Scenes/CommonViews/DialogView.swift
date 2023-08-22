//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

struct DialogView<Content: View>: View {

    @Binding var isDialogPresented: Bool
    let frameHeight: CGFloat
    @ViewBuilder var content: () -> Content

    @State private var offset: CGFloat = .zero
    @State private var size: CGSize = .zero

    var body: some View {
        ZStack {
            if isDialogPresented {
                Color.black
                    .opacity(0.3)
                    .transition(.opacity)
                    .onTapGesture {
                        isDialogPresented = false
                    }
            }
            VStack {
                Spacer()
                VStack(spacing: .zero) {
                    HStack {
                        Spacer()
                        Capsule()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.gray)
                            .padding(.horizontal)
                            .onTapGesture {
                                isDialogPresented = false
                            }
                    }
                    .frame(height: 50)
                    .background(Color.white)
                    content()
                }
                .saveSize(in: $size)
                .cornerRadius(20)
                .padding(.horizontal)
                .transition(.move(edge: .bottom))
                .offset(y: isDialogPresented ? -(UIScreen.main.bounds.height / 2 - frameHeight / 2) : UIScreen.main.bounds.height / 2 + frameHeight / 2)
            }
        }
        .ignoresSafeArea()
    }
}
