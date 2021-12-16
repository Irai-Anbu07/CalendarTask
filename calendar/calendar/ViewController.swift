//
//  ViewController.swift
//  calendar
//
//  Created by iraiAnbu on 29/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
      
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let calendarViewController = calendarViewController()
//            baseDate: Date() ,
//            selectedDateChanged: { [weak self] date in
//            guard let self = self else { return }
//
//            })
        
        let controller = UINavigationController(rootViewController: calendarViewController)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        self.present(controller, animated: false , completion: nil)
    }


}

