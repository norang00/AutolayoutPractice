//
//  ViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 12/31/24.
//

import UIKit

class ViewController_Archive: UIViewController {

    @IBOutlet var levelButtons: [UIButton]!
    let levels: [String] = ["EASY", "NORMAL", "HARD"]
    let levelColors: [UIColor] = [.yellow, .green, .red]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 스토리보드 상의 화면과 시뮬레이터 화면이 조금 다른 것 같다.
        // 다이나믹 아일랜드 위치가 잘못 배치되어 있는 것 같다.
        
        for index in 0..<levelButtons.count {
            let button = levelButtons[index]
            button.setTitle(levels[index], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = levelColors[index]
            button.layer.cornerRadius = 8
        }
    }
    
    @IBAction func unwindToViewController(_ sender: UIStoryboardSegue) {
        print(self, #function)
    }
}
