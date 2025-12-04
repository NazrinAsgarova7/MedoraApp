//
//  ReviewController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import UIKit

class ReviewController: BaseController {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let refreshControl = UIRefreshControl()
    private var vm: ReviewViewModel
    
    init(vm: ReviewViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Reviews"
        let rightBarButton: UIBarButtonItem = .init(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(tappedAddReviewButton))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func configVM() {
        vm.getDoctorReviews()
        vm.completion = { [weak self] viewState in
            switch viewState {
            case .success:
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func configConstraint() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func tappedAddReviewButton() {
        showRatingAlert { [weak self] rating, comment in
            self?.vm.postReview(rate: rating, comment: comment ?? "")
        }
    }
    @objc private func pullToRefresh() {
       // vm.removeAllData()
        tableView.reloadData()
        vm.getDoctorReviews()
    }
}

extension ReviewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        cell.configUI(review: vm.reviews?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.19
    }
}
