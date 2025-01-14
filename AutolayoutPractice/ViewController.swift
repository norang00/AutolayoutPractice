//
//  ViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/13/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
//    lazy var netflixButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("netflix", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .netflixRed
//        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var npayButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("npay", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .npayGreen
//        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        return button
//    }()
    
    lazy var lottoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lotto", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var movieButton: UIButton = {
        let button = UIButton()
        button.setTitle("Movie", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        
        configureUI()
    }
    
    func configureUI() {
        [lottoButton, movieButton].forEach {
            view.addSubview($0)
        }
        
        lottoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
            make.width.equalTo(200)
        }

        movieButton.snp.makeConstraints { make in
            make.top.equalTo(lottoButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
            make.width.equalTo(200)
        }
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        print(#function, sender.titleLabel?.text)
        guard let title = sender.titleLabel?.text else {
            print("no title!")
            return
        }
        
        switch title {
        case "Lotto":
            navigationController?.pushViewController(LottoViewController(), animated: true)
        case "Movie":
            navigationController?.pushViewController(MovieViewController(), animated: true)
        default:
            print("no view controller")
        }
    }
}

#Preview {
    ViewController()
}
