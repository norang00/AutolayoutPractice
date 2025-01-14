//
//  MovieViewController.swift
//  AutolayoutPractice
//
//  Created by Kyuhee hong on 1/13/25.
//

import Alamofire
import SnapKit
import UIKit

class MovieViewController: UIViewController {
    
    let tapGesture = UITapGestureRecognizer()
    
    let backgroundImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moviebg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let overlayView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.7
        return view
    }()
    
    let searchView = UIView()
    lazy var searchTextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "예시: 20250115",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .white
        textField.textAlignment = .left
        textField.borderStyle = .none
        textField.tintColor = .white
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    let textFieldUnderBar = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.backgroundColor = .white
        button.isEnabled = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tableView = UITableView(frame: .zero)
    var movieList: [DailyBoxOfficeList] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "일간 박스오피스"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        configureTabGesture()
        
        setBackgroundView()
        setSearchView()
        
        func firstTask(completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                sleep(2)
                self.getYesterdayData()
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
        
        func secondTask() {
            setTableView()
        }
        
        firstTask {
            secondTask()
        }
        //        getYesterdayData()
        //        setBackgroundView()
        //        setSearchView()
        //        setTableView()
    }
    
}

// MARK: - Data load
extension MovieViewController {
    func getYesterdayData() {
        let yesterday = DateCalculator.getYesterday()
        getBoxOfficeData(yesterday)
    }
    
    func getBoxOfficeData(_ date: String) {
        movieList = []
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=87fea7fcd65acfc45d6c523a3ca8711e&targetDt=\(date)"
        AF.request(url).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                for index in 0..<10 {
                    let movie = value.boxOfficeResult.dailyBoxOfficeList[index]
                    self.movieList.append(DailyBoxOfficeList(rank: movie.rank,
                                                             movieNm: movie.movieNm,
                                                             openDt: movie.openDt))
                }
            case .failure(let error):
                print(error)
            }
        }
        /* [고민]
         아무 숫자 (88888888 같은) 넣어서 돌아오는 값이 없으면 없다고 알려주려고 했는데 왜인지 최신값으로 불러와진다...
         */
    }
}
 
// MARK: - Setting View
extension MovieViewController {
    func setBackgroundView() {
        [backgroundImageView, overlayView].forEach {
            view.addSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setSearchView() {
        [searchTextField, textFieldUnderBar, searchButton].forEach {
            searchView.addSubview($0)
        }
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(44)
        }
        
        textFieldUnderBar.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo(searchTextField.snp.width)
        }
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(textFieldUnderBar.snp.bottom)
            make.leading.equalTo(searchTextField.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
    }
    
    func setTableView() {
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.backgroundColor = .clear
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Setting Function Connected with View
extension MovieViewController {
    
    @objc func searchButtonTapped() {
        guard let input = searchTextField.text else { return }
        getBoxOfficeData(input)
        searchButton.isEnabled = false
    }
    
    @objc func textFieldEditingChanged() {
        guard let text = searchTextField.text?.trimmingCharacters(in: [" "]) else { return }
        if text.count == 8 {
            searchButton.isEnabled = true
        } else if text.count > 8 {
            searchTextField.text = ""
        } else {
            searchButton.isEnabled = false
        }
    }
   
}

// MARK: - TableView
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.configureData(movieList[indexPath.row])
        return cell
    }
}

// MARK: - Gesture
extension MovieViewController: UIGestureRecognizerDelegate {
    func configureTabGesture() {
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
//
//#Preview {
//    MovieViewController()
//}
