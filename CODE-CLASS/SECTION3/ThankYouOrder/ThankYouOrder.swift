//
//  ThankYouOrder.swift
//  nopcommerce app
//
//  Created by Sandipan on 28/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class ThankYouOrder: UIViewController {

    @IBOutlet var lblOrderId: UILabel!
    var strOrderId = String()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        //let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblOrderId.text = strOrderId
    }

    // MARK: - press Home method
    @IBAction func pressHome(_ sender: Any)
    {
        for controller in self.navigationController!.viewControllers as Array
        {
            if controller.isKind(of: CartTab.self)
            {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
}
