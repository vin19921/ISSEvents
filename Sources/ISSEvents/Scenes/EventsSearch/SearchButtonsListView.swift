//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct SearchButtonsListView: View {
    @Binding var selectedIndices: [Int]
    let colors: [Color] = [Color.red,
                           Color.green,
                           Color.blue,
                           Color.gray,
                           Color.orange,
                           Color.black,
                           Color.white]
    @Binding var isSelected: [Bool]
    @Binding var isSheetPresented: [Bool]
    @Binding var canReopenSheet: [Bool]
    @Binding var buttonText: [String]
    let badgeCount: [Int?]
    @Binding var searchTextFieldFirstResponder: Bool
    let isRefreshing: Bool

    @Environment(\.viewController) private var viewControllerHolder: UIViewController?

    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollViewProxy in
                HStack(alignment: .center, spacing: 8) {
                    IconButtonWithText(icon: "calendar",
                                       text: $buttonText[0],
                                       selected: $isSelected[0], action: {
                        // Handle the button action here
                        print("Date button tapped isSelected::: \(isSelected[0])")
                        searchTextFieldFirstResponder = false
                        if isSelected[0] {
                            isSheetPresented[0] = true
                            isSelected[0] = false
                        } else {
                            buttonText[0] = "Date"
                        }
                    }, toggleEachTap: true, disabled: isRefreshing)
                    .padding(.leading)

                    IconButtonWithText(icon: "dot.square",
                                       text: $buttonText[1],
                                       selected: $isSelected[1], action: {
                        // Handle the button action here
                        print("Type button tapped")
                        print("isSelected[1]::: \(isSelected[1])")
                        print("canReopenSheet[1]::: \(canReopenSheet[1])")
                        searchTextFieldFirstResponder = false
                        isSheetPresented[1] = true
                    }, toggleEachTap: false, badgeCount: badgeCount[1], disabled: isRefreshing)
                    .padding(.trailing)
                    
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.bottom)
                .frame(width: UIScreen.main.bounds.width)
            }
        }
        .background(Theme.current.backgroundGray.color)
    }

    private func toggleSelection(index: Int) {
        if isSelected(index: index) {
            selectedIndices.removeAll { $0 == index }
        } else {
            selectedIndices.append(index)
        }
    }

    private func isSelected(index: Int) -> Bool {
        selectedIndices.contains(index)
    }
}

struct IconButtonWithText: View {
    var icon: String
    @Binding var text: String
    @Binding var selected: Bool
    var action: () -> Void
    var toggleEachTap: Bool
    var badgeCount: Int?
    var disabled: Bool?

    var body: some View {
        Button(action: {
            if toggleEachTap {
                selected.toggle()
            }
            action()
        }) {
            HStack(spacing: 10) {
                if !selected {
                    Image(systemName: icon)
                }

                Text(text)
                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                        verticalPadding: 0)
                if let count = badgeCount, count > 1 {
                    BadgeCountIcon(count: count)
                }

                if toggleEachTap {
                    if selected {
                        Image(systemName: "xmark")
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .foregroundColor(selected ? .white : disabled ?? false ? Color.red : Theme.current.issBlack.color)
            .background(selected ? Color.black.opacity(0.5) : Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.5), lineWidth: 2)
            )
            .animation(.easeOut(duration: 0.2))
        }
        .disabled(disabled ?? false)
    }
}

struct BadgeCountIcon: View {
    let count: Int

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: 18, height: 18)
            
            Text("\(count)")
                .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                    lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                    verticalPadding: 0)
                .foregroundColor(.white)
        }
    }
}
