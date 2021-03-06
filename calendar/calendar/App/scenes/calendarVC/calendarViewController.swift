//
//  calendarViewController.swift
//  calendar
//
//  Created by iraiAnbu on 30/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol calendarDisplayLogic: AnyObject
{
    func displaySomething(viewModel: CalendarVC.Something.ViewModel)
}

class calendarViewController: UIViewController, calendarDisplayLogic
{
    var interactor: calendarBusinessLogic?
    var router: (NSObjectProtocol & calendarRoutingLogic & calendarDataPassing)?
    
    // MARK: Object lifecycle
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = calendarInteractor(baseDate: Date(), selectedDateChanged: { [weak self] date in
            guard self != nil else { return }
            
        })
        let presenter = calendarPresenter()
        let router = calendarRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    private lazy var footerView = CalendarPickerFooterView(
        didTapLastMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }
            
            
            if let interactor = self.interactor {
                let ( previousDays , baseDate )  =  interactor.previousMonth()
                self.days = previousDays
                self.collectionView.reloadData()
                self.headerView.baseDate = baseDate!
                
            }
            
        },
        didTapNextMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }
            
            
            if let interactor = self.interactor {
                let ( previousDays , baseDate )  =  interactor.nextmonth()
                self.days = previousDays
                self.collectionView.reloadData()
                self.headerView.baseDate = baseDate!
                
            }
            
        })
    
    
    var selectedDateChanged:Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        addSubViews()
        
        updateConstraints()
        
        doSomething()
        
        updateUI()
    }
    
    func addSubViews() {
        view.addSubview(collectionView)
        view.addSubview(headerView)
        view.addSubview(footerView)
    }
    
    func updateConstraints() {
        var constraints = [
            collectionView.leadingAnchor.constraint(
                equalTo: view.readableContentGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(
                equalTo: view.readableContentGuide.trailingAnchor),
            
            collectionView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor,
                constant: 10),
            
            collectionView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.5)
            
        ]
        
        
        constraints.append(contentsOf: [
            headerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 85),
            
            footerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            footerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateUI() {
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        collectionView.register(
            CalendarDateCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .white
    }
    
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var headerView = CalendarPickerHeaderView { [weak self] in
        guard let self = self else { return }
        
        self.dismiss(animated: true)
    }
    
    var days: [Day] = []
    
    
    func doSomething()
    {
        let request = CalendarVC.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CalendarVC.Something.ViewModel)
    {
        
        if let datesChanged = viewModel.numberOfWeeksinBaseDate {
            self.selectedDateChanged = datesChanged
        }
        
        
        if let BaseDate = viewModel.baseDate {
            headerView.baseDate = BaseDate
        }
            
        if let day = viewModel.days {
            self.days = day
            self.collectionView.reloadData()
        }
    }
    
}




extension calendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        days.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let day = days[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier,
            for: indexPath) as! CalendarDateCollectionViewCell
        // swiftlint:disable:previous force_cast
        
        cell.day = day
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension calendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let day = days[indexPath.row]
        //        selectedDateChanged(day.date)
//        dismiss(animated: true, completion: nil)
        
        let vc = newEventViewController()
        vc.modalPresentationStyle = .popover
        vc.selectedDate = day.date
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / (selectedDateChanged ?? 4 )
        return CGSize(width: width, height: height)
    }
}


