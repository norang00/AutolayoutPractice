//
//  LottoViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/14/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController, ViewProtocol {
   
    let tapGesture = UITapGestureRecognizer()
    
    let textField = UITextField()
    let pickerView = UIPickerView()
    
    let infoStackView = UIStackView()
    let underLineView = UIView()
    let guideLabel = UILabel()
    let dateLabel = UILabel()
    let resultLabel = UILabel()
    
    let numberStackView = UIStackView()
    var numberBalls: [UILabel] = []
    let bonusLabel = UILabel()

    var numbers: [Int] = Array(1...1154).reversed()
    
    var selectedNumber: Int = 0 {
        didSet {
            textField.text = String(selectedNumber)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .white
        navigationItem.title = "Lotto"
        navigationController?.navigationBar.tintColor = .black
        
        pickerView.delegate = self
        pickerView.dataSource = self

        makeNumberBalls()

        configureHierarchy()
        configureLayout()
        configureView()
        configureTabGesture()
    }
    
    func makeNumberBalls() {
        for _ in 0..<8 {
            numberBalls.append(UILabel())
        }
    }
    
    func configureHierarchy() {
        [guideLabel, dateLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        numberBalls.forEach {
            numberStackView.addArrangedSubview($0)
            numberStackView.setCustomSpacing(2, after: $0)
            print($0)
        }
        
        [textField, infoStackView, underLineView, resultLabel, numberStackView, bonusLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoStackView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(underLineView.snp.bottom).offset(40)
        }
        
        numberStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(22)
            make.height.equalTo(40)
        }
    }
    
    func configureView() {
        textField.placeholder = "회차를 검색해보세요"
        textField.borderStyle = .roundedRect
        textField.inputView = pickerView
        textField.addTarget(self, action: #selector(textFieldTapped), for: .touchUpInside)
        textField.addTarget(self, action: #selector(textFieldEndOnExit), for: .editingDidEndOnExit)
        
        guideLabel.text = "당첨번호 안내"
        guideLabel.textColor = .black
        guideLabel.textAlignment = .left
        guideLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        dateLabel.text = "2020-05-30 추첨"
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        underLineView.backgroundColor = .lightGray
        
        resultLabel.text = "당첨결과"
        resultLabel.textColor = .lottoTitleYellow
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 25, weight: .bold)
        let text = resultLabel.text ?? ""
        let attributedString = NSMutableAttributedString(string: resultLabel.text ?? "")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "당첨결과"))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .regular), range: (text as NSString).range(of: "당첨결과"))
        resultLabel.attributedText = attributedString
        
        numberStackView.distribution = .fillEqually
        for (index, label) in numberBalls.enumerated() {
            if index == 6 {
                    label.text = "+"
                    label.textColor = .black
                    label.textAlignment = .center
                label.font = .systemFont(ofSize: 16, weight: .bold)
                    label.frame.size = CGSize(width: 50, height: 50)
                    label.layer.backgroundColor = UIColor.white.cgColor
                    label.layer.cornerRadius = 25
            } else {
                label.text = "0"
                label.textColor = .white
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 20, weight: .semibold)
                label.frame.size = CGSize(width: 40, height: 40)
                label.layer.backgroundColor = UIColor.black.cgColor
                label.layer.cornerRadius = 20
            }
        }
        
        bonusLabel.text = "보너스"
        bonusLabel.textColor = .lottoGray
        bonusLabel.textAlignment = .center
        bonusLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }

}

extension LottoViewController {
    @objc
    func textFieldTapped() {
        print(#function)

    }
    
    @objc
    func textFieldEndOnExit() {
        print(#function)

    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function)
        selectedNumber = numbers[row]
        textField.text = "\(selectedNumber)"
        resultLabel.text = "\(selectedNumber)회 당첨결과"

        // 서버 통신 시작
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numbers[row])
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

extension LottoViewController: UIGestureRecognizerDelegate {
    func configureTabGesture() {
        tapGesture.delegate = self
//        self.view.addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(#function)
        self.view.endEditing(true)
        return true
    }
}

#Preview {
    LottoViewController()
}
