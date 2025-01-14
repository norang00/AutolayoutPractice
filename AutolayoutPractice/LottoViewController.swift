//
//  LottoViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/14/25.
//

import Alamofire
import SnapKit
import UIKit

struct Lotto: Decodable {
    let drwNoDate: String
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController, ViewConfiguration {
    
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
    
    var numbers: [Int] = []
    
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
        
        calculateDate()
        makeNumberBalls()
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureTabGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func calculateDate() {
        let pastDays: Double = Double(DateCalculator.calculateDays())
        let round: Int = Int(ceil(pastDays/7))
        numbers = Array(1...round).reversed()
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
        
        bonusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(numberBalls[7])
            make.top.equalTo(numberBalls[7].snp.bottom).offset(6)
            make.height.equalTo(16)
        }
    }
    
    func configureView() {
        textField.placeholder = "회차를 검색해보세요"
        textField.borderStyle = .roundedRect
        textField.inputView = pickerView
        
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
        resultLabel.font = .systemFont(ofSize: 24, weight: .regular)
        
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
        bonusLabel.textColor = .gray
        bonusLabel.textAlignment = .center
        bonusLabel.font = .systemFont(ofSize: 14, weight: .medium)
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNumber = numbers[row]
        textField.text = "\(selectedNumber)"
        resultLabel.text = "\(selectedNumber)회 당첨결과"
        setAttributedText()
       
        // 서버 통신 시작
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(selectedNumber)"
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.dateLabel.text = "\(value.drwNoDate) 추첨"
                
                var numbers: [Int] = []
                numbers.append(value.drwtNo1)
                numbers.append(value.drwtNo2)
                numbers.append(value.drwtNo3)
                numbers.append(value.drwtNo4)
                numbers.append(value.drwtNo5)
                numbers.append(value.drwtNo6)
                numbers.sort()
                self.drawNumberBall(numbers, value.bnusNo)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func drawNumberBall(_ numbers: [Int], _ bonus: Int) {
        for index in 0..<6 {
            let numberBall = numberBalls[index]
            let number = numbers[index]
            numberBall.text = "\(number)"
            paintNumberBall(number, numberBall)
        }
        
        let bonusBall = numberBalls[7]
        bonusBall.text = "\(bonus)"
        paintNumberBall(bonus, bonusBall)
    }
    
    func paintNumberBall(_ number: Int, _ numberBall: UILabel) {
        switch number {
        case 0..<10:
            numberBall.layer.backgroundColor = UIColor.lottoYellow.cgColor
        case 10..<20:
            numberBall.layer.backgroundColor = UIColor.lottoBlue.cgColor
        case 20..<30:
            numberBall.layer.backgroundColor = UIColor.lottoRed.cgColor
        case 30..<40:
            numberBall.layer.backgroundColor = UIColor.lottoGray.cgColor
        case 40...:
            numberBall.layer.backgroundColor = UIColor.lottoGreen.cgColor
        default:
            print("default")
        }
    }

    func setAttributedText() {
        resultLabel.textColor = .lottoTitleYellow
        resultLabel.font = .systemFont(ofSize: 24, weight: .bold)
        let text = resultLabel.text ?? ""
        let attributedString = NSMutableAttributedString(string: resultLabel.text ?? "")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "당첨결과"))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .regular), range: (text as NSString).range(of: "당첨결과"))
        resultLabel.attributedText = attributedString
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
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

#Preview {
    LottoViewController()
}
