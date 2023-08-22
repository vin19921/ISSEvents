//
//  MonthPickerView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct MonthPickerView: View {
    let months = DateHelper.monthSymbols() // Array of month names
    let monthSelected: (String) -> Void // Action callback
    let columns = 3

    @Binding var selectedMonth: String
    
    init(selectedMonth: Binding<String>, monthSelected: @escaping (String) -> Void) {
        _selectedMonth = selectedMonth
        self.monthSelected = monthSelected
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                ForEach(0..<months.count / 4, id: \.self) { rowIndex in
                    MonthRowView(rowIndex: rowIndex, months: months, geometry: geometry, selectedMonth: selectedMonth, monthTapped: { month in
                        selectedMonth = month
                    })
                }
            }
            .padding()
            .frame(height: 168)
        }
    }

    private func monthTapped(_ month: String) {
        if selectedMonth == month {
            selectedMonth = month
        } else {
            selectedMonth = month
        }

        monthSelected(selectedMonth)
    }
}

struct DateHelper {
    static func monthSymbols() -> [String] {
        let dateFormatter = DateFormatter()
        return dateFormatter.standaloneMonthSymbols
    }
}

struct MonthButtonView: View {
    let month: String
    let geometry: GeometryProxy
    let selectedMonth: String?
    let monthTapped: (String) -> Void

    var body: some View {
        Button(action: {
            monthTapped(month)
        }) {
            HStack {
                Text(month)
                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                        verticalPadding: 0)
            }
            .frame(width: (geometry.size.width - 56) / 4, height: 40)
            .foregroundColor(selectedMonth == month ? .white : .black)
            .background(selectedMonth == month ? Color.black : Color.white)
        }
        .cornerRadius(20)
    }
}

struct MonthRowView: View {
    let rowIndex: Int
    let months: [String]
    let geometry: GeometryProxy
    let selectedMonth: String?
    let monthTapped: (String) -> Void

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<4) { columnIndex in
                let index = rowIndex * 4 + columnIndex
                if index < months.count {
                    MonthButtonView(month: months[index], geometry: geometry, selectedMonth: selectedMonth, monthTapped: monthTapped)
                } else {
                    Spacer()
                }
            }
        }
    }
}

