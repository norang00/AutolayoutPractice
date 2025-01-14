//
//  ViewProtocol.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/14/25.
//

import Foundation

protocol ViewConfiguration: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
