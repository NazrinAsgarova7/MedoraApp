//
//  BottomSheetController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

class BottomSheet: BaseController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(BottomSheetCell.self, forCellWithReuseIdentifier: "\(BottomSheetCell.self)")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    private lazy var nextButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Next", for: .normal)
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint   = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(named: "buttonStart"), for: .normal)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(named: "buttonStart")
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let onboardingScreens: [BottomSheetCellProtocol] = [
        BottomSheetCellModel(title: "Your Health & Wellness On-Demand", description: "Urna amet, suspendisse ullamcorper ac elit diam facilisis cursus vestibulum."),
          BottomSheetCellModel(title: "Wellness at Your Fingertips with Doctor+", description: "Wellness at Your Fingertips with Doctor+"),
          BottomSheetCellModel(title: "Your Health & Wellness On-Demand", description: "Urna amet, suspendisse ullamcorper ac elit diam facilisis cursus vestibulum.")]
    
    var callbackController: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func configConstraint() {
        [collectionView, nextButton, skipButton, pageControl].forEach { element in
                   view.addSubview(element)
               }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 28),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.widthAnchor.constraint(equalToConstant: 327),
            skipButton.heightAnchor.constraint(equalToConstant: 56),
            
            nextButton.widthAnchor.constraint(equalToConstant: 327),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -8),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -28)
        ])
    }
    
    @objc func tappedNextButton() {
        if nextButton.titleLabel?.text == "Get Started" {
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let delegate = scene.delegate as? SceneDelegate else { return }
            delegate.registerRoot()
        }
        
        pageControl.currentPage += 1
        if pageControl.currentPage + 1 == onboardingScreens.count {
            nextButton.setTitle("Get Started", for: .normal)
            skipButton.setTitle("Already Have an Account?", for: .normal)
        }
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
       
    }
}

extension BottomSheet: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingScreens.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           willDisplay cell: UICollectionViewCell,
                           forItemAt indexPath: IndexPath) {
           callbackController?(indexPath.item)
       }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BottomSheetCell.self)", for: indexPath) as! BottomSheetCell
        cell.config(model: onboardingScreens[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
