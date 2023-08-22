//
//  YearPickerView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct YearPickerView: View {
    @Binding var selectedYear: Int
    var startYear: Int
    var endYear: Int
    var yearSelected: (Int) -> Void
    
    init(selectedYear: Binding<Int>, startYear: Int, endYear: Int, yearSelected: @escaping (Int) -> Void) {
        _selectedYear = selectedYear
        self.startYear = startYear
        self.endYear = endYear
        self.yearSelected = yearSelected
        
        // Initialize selectedYear with the current year if it's not within the range of startYear to endYear.
        if selectedYear.wrappedValue < startYear || selectedYear.wrappedValue > endYear {
            selectedYear.wrappedValue = Calendar.current.component(.year, from: Date())
        }
    }

    var body: some View {
        HStack(spacing: 18) {
            Button(action: {
                decrementYear()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(selectedYear <= startYear ? .gray : .black)

                }
            }
            .disabled(selectedYear <= startYear)

            Text("\(yearWithoutCommas(selectedYear))")
                .fontWithLineHeight(font: Theme.current.bodyOneMedium.uiFont,
                                    lineHeight: Theme.current.bodyOneMedium.lineHeight,
                                    verticalPadding: 0)

            Button(action: {
                incrementYear()
            }) {
                HStack {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(selectedYear >= endYear ? .gray : .black)
                }
            }
            .disabled(selectedYear >= endYear)
        }
        .frame(height: 40)
    }

    private func incrementYear() {
        if selectedYear < endYear {
            selectedYear += 1
            yearSelected(selectedYear)
        }
    }

    private func decrementYear() {
        if selectedYear > startYear {
            selectedYear -= 1
            yearSelected(selectedYear)
        }
    }

    private func yearWithoutCommas(_ year: Int) -> String {
         return String(year)
     }
}
