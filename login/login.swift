//
//  login.swift
//  Saudi Fisheries
//
//  Created by Sandipan on 18/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class login: UIViewController {
    
    
    @IBOutlet var imgvCompanyLogo: UIImageView!
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnForgotPassword: UIButton!
    @IBOutlet var btnRegister: UIButton!
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupborder()
    }

    //MARK: - Setup Border stye
    func setupborder() -> Void
    {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtEmail.frame.size.height - width, width: txtEmail.frame.size.width, height: txtEmail.frame.size.height)
        border.borderWidth = width
        txtEmail.layer.addSublayer(border)
        txtEmail.layer.masksToBounds = true
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let border1 = CALayer()
        let width1 = CGFloat(0.5)
        border1.borderColor = UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtPassword.frame.size.height - width1, width: txtPassword.frame.size.width, height: txtPassword.frame.size.height)
        border1.borderWidth = width1
        txtPassword.layer.addSublayer(border1)
        txtPassword.layer.masksToBounds = true
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    //MARK: - press SignIn & ForgotPassword & Register stye
    @IBAction func pressSignIn(_ sender: Any) {
    }
    @IBAction func pressForgotPassword(_ sender: Any) {
    }
    @IBAction func pressRegister(_ sender: Any)
    {
        var obj = Registration()
        let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
            //5S
            //obj = Registration(nibName: "Registration5S", bundle: nil)
        }
        else if (screenSize.height == 480.0){
            //5S
            //obj = Registration(nibName: "Registration4S", bundle: nil)
        }
        else if(screenSize.height == 667.0){
            //6
            obj = Registration(nibName: "Registration", bundle: nil)
        }
        else if(screenSize.height == 736.0){
            // 6Plus
            //obj = Registration(nibName: "Registration6Plus", bundle: nil)
        }
        else if(screenSize.height == 812.0){
            //x
            //obj = Registration(nibName: "RegistrationX", bundle: nil)
        }
        else
        {
            //obj = TenantDashboard(nibName: "TenantDashboardXSMAX", bundle: nil)
            
        }
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}
