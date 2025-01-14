//
//  NetflixViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/13/25.
//

import UIKit
import SnapKit

class NetflixViewController: UIViewController {
    
    let logoImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "netflixLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let joinButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        return button
    }()
    
    let addInfoLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let addInfoSwitch = {
        let swtch = UISwitch()
        swtch.setOn(true, animated: false)
        swtch.onTintColor = .netflixRed
        swtch.backgroundColor = .lightGray
        swtch.layer.cornerRadius = 15
        swtch.thumbTintColor = .white
        return swtch
    }()
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let nicknameTextField = UITextField()
    let locationTextField = UITextField()
    let referralTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = false
        
        setImageView()
        setTextFieldView()
        setButtonAndSwitchView()
    }
    
    func setImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
    }
    
    func setTextFieldView() {
        let textFields = [emailTextField, passwordTextField, nicknameTextField, locationTextField, referralTextField]
        let textFieldPlaceholders: [String] = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]

        for (index, textField) in textFields.enumerated() {
            view.addSubview(textField)

            // 뷰 설정
            textField.attributedPlaceholder = NSAttributedString(
                string: "\(textFieldPlaceholders[index])",
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.white,
                    NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 14)!
                ])
            textField.textColor = .white
            textField.textAlignment = .center
            textField.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            textField.layer.cornerRadius = 6
            textField.backgroundColor = .netflixGray
            
            // 레이아웃 설정
            if index == 0 {
                textField.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(logoImageView.snp.bottom).offset(130)
                    make.leading.equalTo(view).offset(30)
                    make.trailing.equalTo(view).offset(-30)
                    make.height.equalTo(33)
                }
            } else {
                textField.snp.makeConstraints { make in
                    make.centerX.equalTo(view)
                    make.top.equalTo(textFields[index-1].snp.bottom).offset(10)
                    make.leading.equalTo(view).offset(30)
                    make.trailing.equalTo(view).offset(-30)
                    make.height.equalTo(33)
                }
            }
        }
        
    }
    
    func setButtonAndSwitchView() {
        let addView = UIView()
        addView.addSubview(addInfoLabel)
        addView.addSubview(addInfoSwitch)
        [joinButton, addView].forEach {
            view.addSubview($0)
        }
        
        joinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(referralTextField.snp.bottom).offset(15)
            make.height.equalTo(44)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
        
        addInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addInfoSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(joinButton.snp.bottom).offset(15)
            make.height.equalTo(33)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
    }
}

#Preview {
    NetflixViewController()
}
