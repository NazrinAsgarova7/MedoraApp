//
//  BottomSheetController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

class FirstBottomSheet: BaseController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(BottomSheetCell.self, forCellWithReuseIdentifier: "\(BottomSheetCell.self)")
        cv.translatesAutoresizingMaskIntoConstraints = false
        // setup-da
        cv.isScrollEnabled = false
        cv.alwaysBounceHorizontal = false
        cv.showsHorizontalScrollIndicator = false

        return cv
    }()
    
    let onboardingScreens: [BottomSheetCellProtocol] = [
        BottomSheetCellModel(title: "Your Health & Wellness On-Demand", description: "Urna amet, suspendisse ullamcorper ac elit diam facilisis cursus vestibulum.", firstButtonTitle: "Next", secondButtonTitle: "Skip"),
          BottomSheetCellModel(title: "Wellness at Your Fingertips with Doctor+", description: "Wellness at Your Fingertips with Doctor+", firstButtonTitle: "Next", secondButtonTitle: "Skip"),
          BottomSheetCellModel(title: "Your Health & Wellness On-Demand", description: "Urna amet, suspendisse ullamcorper ac elit diam facilisis cursus vestibulum.", firstButtonTitle: "Get Started", secondButtonTitle: "Already have an account")]
    
    var callbackController: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
    override func configConstraint() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
}

extension FirstBottomSheet: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BottomSheetCell.self)", for: indexPath) as! BottomSheetCell
        cell.config(model: onboardingScreens[indexPath.row], index: indexPath.row)
        cell.callbackController = { [weak self] in
            if indexPath.row + 1 < self?.onboardingScreens.count ?? 0 {
                collectionView.scrollToItem(at: IndexPath(item: indexPath.row + 1, section: 0), at: .centeredHorizontally, animated: true)
            } else {
                guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let delegate = scene.delegate as? SceneDelegate else { return }
                delegate.registerRoot()
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
