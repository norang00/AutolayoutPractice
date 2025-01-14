//
//  DateCaculator.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/14/25.
//

import Foundation

class DateCalculator {
    static let calendar = Calendar.current
    static let dateFormatter = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "yyyy-MM-dd"
        return format
    }()
    
    static func calculateDays() -> Int {
        let startDate = dateFormatter.date(from: "2002-12-07")! // 로또 1회차
        let daysCount = calendar.dateComponents([.day], from: startDate, to: Date())
        let result = daysCount.day! + 1 // 시작일 추가
        return result
    }
}
