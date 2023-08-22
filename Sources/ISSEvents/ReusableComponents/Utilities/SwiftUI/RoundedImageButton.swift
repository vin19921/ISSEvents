//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

public struct RoundedImageButton: View {
    // MARK: - View Dependencies

    let height: CGFloat
    let image: Image
    let action: () -> Void

    public init(height: CGFloat, image: Image, action: @escaping () -> Void) {
        self.height = height
        self.image = image
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all, 12)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        .frame(width: height, height: height)
    }
}
