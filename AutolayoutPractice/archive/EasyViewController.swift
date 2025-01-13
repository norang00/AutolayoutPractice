//
//  EasyViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 12/31/24.
//

import UIKit

class EasyViewController: UIViewController {

    @IBOutlet var exitButton: UIButton!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var inputTextFields: [UITextField]!
    @IBOutlet var joinButton: UIButton!
    @IBOutlet var addInfoView: UIView!
    @IBOutlet var addInfoLabel: UILabel!
    @IBOutlet var addInfoSwitch: UISwitch!
    
    var textFieldPlaceholders: [String] = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        exitButton.setTitle("", for: .normal)
        exitButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        exitButton.tintColor = .white
        
        logoImageView.image = UIImage(named: "netflixLogo")
        logoImageView.contentMode = .scaleAspectFit
        
        setTextFieldView()
        setJoinButtonView()
        setAddInfoView()
    }

    func setTextFieldView() {
        for index in 0..<inputTextFields.count {
            let textField = inputTextFields[index]
            textField.attributedPlaceholder = NSAttributedString(
                string: "\(textFieldPlaceholders[index])",
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.white,
                    NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 14)!
                ])
            textField.textColor = .white
            textField.textAlignment = .center
            textField.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            textField.backgroundColor = .netflixGray
        }
    }
    
    func setJoinButtonView() {
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        joinButton.layer.cornerRadius = 8
        joinButton.backgroundColor = .white
    }
    
    func setAddInfoView() {
        addInfoView.backgroundColor = .clear
        
        addInfoLabel.text = "추가 정보 입력"
        addInfoLabel.textColor = .white
        addInfoLabel.textAlignment = .left
        
        addInfoSwitch.setOn(true, animated: false)
        addInfoSwitch.onTintColor = .netflixRed
        addInfoSwitch.backgroundColor = .lightGray
        addInfoSwitch.layer.cornerRadius = 15
        addInfoSwitch.thumbTintColor = .white
    }
}
