//
//  WeatherViewController.swift
//  TechApp
//
//  Created by 이한규 on 2022/02/05.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class WeatherViewController:UIViewController {
    
    private let weatherViewModel = WeatherViewModel()
    
    lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "climate")
        self.view.addSubview(imageView)
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
      let lbl = UILabel(frame: .zero)
      lbl.numberOfLines = 0
      lbl.textAlignment = .center
      lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
      lbl.text = "~~"
      self.view.addSubview(lbl)
      return lbl
    }()
    
    lazy var conditionLabel: UILabel = {
      let lbl = UILabel(frame: .zero)
      lbl.numberOfLines = 0
      lbl.textAlignment = .center
      lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
      lbl.text = "``"
      self.view.addSubview(lbl)
      return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        fetchWeather(byCity: "")
    }
    
    private func fetchWeather(byCity city: String) {
        
        weatherViewModel.fetchWeather(byCity: city) { [weak self] (result) in
            guard let this = self else { return }
            this.handleResult(result)
        }
    }
    
    private func handleResult(_ result: Result<WeatherModel, Error>) {
        switch result {
        case .success(let model):
            updateView(with: model)
        case .failure(let error):
            print("error")
        }
    }
    
    private func updateView(with model: WeatherModel) {
        
        temperatureLabel.text = model.temp.toString().appending("°C")
        conditionLabel.text = model.conditionDescription
        navigationItem.title = model.countryName
        conditionImageView.image = UIImage(named: model.conditionImage)
    }
    
    private func setConstraint(){
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "The Weather"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusWeather))
        
        conditionImageView.snp.makeConstraints{ make in
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints{ make in
            make.top.equalTo(conditionImageView.snp_bottomMargin).offset(16)
            make.centerX.equalToSuperview()
        }
        conditionLabel.snp.makeConstraints{ make in
            make.top.equalTo(temperatureLabel.snp_bottomMargin).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func plusWeather(){
        let controller = AddWeatherViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
