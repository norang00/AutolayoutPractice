//
//  Movie.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/15/25.
//

import Foundation

struct Movie: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
