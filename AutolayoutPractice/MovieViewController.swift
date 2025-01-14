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
    let searchTextField = {
        let textField = UITextField()
        textField.text = "20200401"
        textField.textColor = .white
        textField.textAlignment = .left
        textField.borderStyle = .none
        return textField
    }()
    
    let textFieldUnderBar = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let searchButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    let tableView = UITableView(frame: .zero)
    let data = Movie.movieList

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie"
        navigationController?.navigationBar.tintColor = .black
        
        setBackgroundView()
        setSearchView()
        setTableView()
    }
    
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

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.configureData(data[indexPath.row])
        return cell
    }
}

struct Movie {
    
    var number: Int
    var title: String
    var date: String
    
    static let movieList = [
        Movie(number: 1, title: "엽문4: 더 파이널", date: "2020-04-01"),
        Movie(number: 2, title: "주디", date: "2020-03-25"),
        Movie(number: 3, title: "1917", date: "2020-02-19"),
        Movie(number: 4, title: "인비저블맨", date: "2020-02-26"),
        Movie(number: 5, title: "n번째 이별 중", date: "2020-04-01"),
        Movie(number: 6, title: "스케어리 스토리: 어둠의 속삭임", date: "2020-03-25"),
        Movie(number: 7, title: "날씨의 아이", date: "2019-10-30"),
        Movie(number: 8, title: "라라랜드", date: "2016-12-07"),
        Movie(number: 9, title: "너의 이름은.", date: "2017-01-04"),
        Movie(number: 10, title: "다크 워터스", date: "2020-03-11")
    ]
}

#Preview {
    MovieViewController()
}
