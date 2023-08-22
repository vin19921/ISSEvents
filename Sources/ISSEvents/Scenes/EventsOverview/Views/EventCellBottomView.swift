//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventCellBottomView: View {
    @Binding var isExpanded: Bool
    var onTapInfoAction: (() -> Void)?
    var onTapCartAction: (() -> Void)?
    @State private var isFavorite = false

    var body: some View {
        GeometryReader { geometry in
            if isExpanded {
                HStack(spacing: .zero) {
                    HStack {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .padding(.vertical, 8)
                    }
                    .frame(width: geometry.size.width / 3)
                    .background(Theme.current.issBlack.color)
                    .foregroundColor(.white)
                    .onTapGesture {
                        print("Button 1 tapped")
                        onTapInfoAction?()
                    }
                    
                    Rectangle()
                        .fill(Theme.current.issWhite.color)
                        .frame(width: 1, height: 32)
//
                    HStack {
                        Image(systemName: "cart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .padding(.vertical, 8)
                    }
                    .frame(width: geometry.size.width / 3)
                    .background(Theme.current.issBlack.color)
                    .foregroundColor(.green)
                    .onTapGesture {
//                        print("Button 2 tapped")
                        onTapCartAction?()
                    }

                    Rectangle()
                        .fill(Theme.current.issWhite.color)
                        .frame(width: 1, height: 32)
                    
                    HStack {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .padding(.vertical, 8)
                    }
                    .frame(width: geometry.size.width / 3)
                    .background(Theme.current.issBlack.color)
                    .foregroundColor(.red)
                    .onTapGesture {
                        isFavorite.toggle()
                        print("Button 3 isFavorite ::: \(isFavorite)")
                    }

//                    Image(systemName: "info.circle")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: geometry.size.width / 3, height: 16)
//                        .padding(.vertical, 8)
//                        .onTapGesture {
//                            print("Button 1 tapped")
//                        }
//                    Image(systemName: "cart")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: geometry.size.width / 3, height: 16)
//                        .padding(.vertical, 8)
//                        .onTapGesture {
//                            print("Button 2 tapped")
//                        }
//                    Image(systemName: "heart")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: geometry.size.width / 3, height: 16)
//                        .padding(.vertical, 8)
//                        .onTapGesture {
//                            print("Button 3 tapped")
//                        }
                }
            }
        }
        .frame(height: isExpanded ? 32: 0)
    }
}
