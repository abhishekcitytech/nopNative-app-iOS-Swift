//
//  login.swift
//  nopcommerce app
//
//  Created by Sandipan on 18/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class login: UIViewController,UITextFieldDelegate
{
    @IBOutlet var imgvCompanyLogo: UIImageView!
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnForgotPassword: UIButton!
    @IBOutlet var btnRegister: UIButton!
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    var viewForgotPasswordControlPop = UIControl()
    var viewForgotPasswordPop = UIView()
    var txtForgotEmailPop = UITextField()
    
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
        
        btnSignIn.layer.borderColor = UIColor.clear.cgColor
        btnSignIn.layer.borderWidth = 1.0
        btnSignIn.layer.cornerRadius = 2.0
        btnSignIn.layer.masksToBounds = true
    }

    //MARK: - Setup Border stye
    func setupborder() -> Void
    {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtEmail.frame.size.height - width, width: txtEmail.frame.size.width, height: txtEmail.frame.size.height)
        border.borderWidth = width
        txtEmail.layer.addSublayer(border)
        txtEmail.layer.masksToBounds = true
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        let border1 = CALayer()
        let width1 = CGFloat(0.5)
        border1.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtPassword.frame.size.height - width1, width: txtPassword.frame.size.width, height: txtPassword.frame.size.height)
        border1.borderWidth = width1
        txtPassword.layer.addSublayer(border1)
        txtPassword.layer.masksToBounds = true
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: - press SignIn
    @IBAction func pressSignIn(_ sender: Any)
    {
        if txtEmail.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter email", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtPassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter password", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.getLogin(strUsername: txtEmail.text!, strPassword: txtPassword.text!)
        }
    }
    
    //MARK: - press ForgotPassword
    @IBAction func pressForgotPassword(_ sender: Any)
    {
        self.createForgotPasswordPopUp()
    }
    
    //MARK: - press Register stye
    @IBAction func pressRegister(_ sender: Any)
    {
        let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
        let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
        self.navigationController?.pushViewController(Registration, animated: true)
        
       /* let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
        }
        else if (screenSize.height == 480.0){
        }
        else if(screenSize.height == 667.0){
            let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
            let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
            self.navigationController?.pushViewController(Registration, animated: true)
        }
        else if(screenSize.height == 736.0){
            let storyBoard = UIStoryboard(name: "SectionFive6SPlus", bundle: nil)
            let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
            self.navigationController?.pushViewController(Registration, animated: true)
        }
        else if(screenSize.height == 812.0){
            let storyBoard = UIStoryboard(name: "SectionFiveXS", bundle: nil)
            let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
            self.navigationController?.pushViewController(Registration, animated: true)
        }
        else{
            let storyBoard = UIStoryboard(name: "SectionFiveXSMAX", bundle: nil)
            let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
            self.navigationController?.pushViewController(Registration, animated: true)
        }*/
    }
    
    // MARK: - showLoadingMode Method
    func showLoadingMode()
    {
        loadingCircle.removeFromSuperview()
        loadingCircle = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        loadingCircle.backgroundColor = UIColor.black
        loadingCircle.alpha = 0.6
        
        circle = UIView ()
        circle.backgroundColor = UIColor.white
        circle.alpha = 1.0
        let size = 60
        let size1 = 60
        var frame = circle.frame
        frame.size.width = CGFloat(size)
        frame.size.height = CGFloat(size1)
        frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
        circle.frame = frame
        circle.center = self.view.center
        circle.layer.cornerRadius = 30.0
        circle.layer.borderWidth = 1.0
        circle.layer.borderColor=UIColor.white.cgColor
        circle.layer.masksToBounds = true
        
        /*let imgvLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
         imgvLogo.backgroundColor = UIColor.clear
         imgvLogo.image = UIImage(named:"productlogo")
         circle.addSubview(imgvLogo)*/
        
        let  animatedImageView =  UIImageView(frame: circle.bounds)
        animatedImageView.animationImages = NSArray(objects:UIImage(named: "frame-0.png")!,
                                                    UIImage(named: "frame-1.png")!,
                                                    UIImage(named: "frame-2.png")!,
                                                    UIImage(named: "frame-3.png")!,
                                                    UIImage(named: "frame-4.png")!,
                                                    UIImage(named: "frame-5.png")!,
                                                    UIImage(named: "frame-6.png")!,
                                                    UIImage(named: "frame-7.png")!,
                                                    UIImage(named: "frame-8.png")!,
                                                    UIImage(named: "frame-9.png")!,
                                                    UIImage(named: "frame-10.png")!,
                                                    UIImage(named: "frame-11.png")!,
                                                    UIImage(named: "frame-12.png")!,
                                                    UIImage(named: "frame-13.png")!,
                                                    UIImage(named: "frame-14.png")!,
                                                    UIImage(named: "frame-15.png")!,
                                                    UIImage(named: "frame-16.png")!,
                                                    UIImage(named: "frame-17.png")!,
                                                    UIImage(named: "frame-18.png")!,
                                                    UIImage(named: "frame-19.png")!,
                                                    UIImage(named: "frame-20.png")!,
                                                    UIImage(named: "frame-21.png")!,
                                                    UIImage(named: "frame-22.png")!,
                                                    UIImage(named: "frame-23.png")!,
                                                    UIImage(named: "frame-24.png")!,
                                                    UIImage(named: "frame-25.png")!,
                                                    UIImage(named: "frame-26.png")!,
                                                    UIImage(named: "frame-27.png")!,
                                                    UIImage(named: "frame-28.png")!,
                                                    UIImage(named: "frame-29.png")!) as? [UIImage]
        
        animatedImageView.animationDuration = 9
        animatedImageView.animationRepeatCount = 0
        animatedImageView.startAnimating()
        circle.addSubview(animatedImageView)
        circle.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        
        self.view.addSubview(circle)
        self.view.addSubview(loadingCircle)
        self.view.bringSubviewToFront(circle)
        
        
    }
    func hideLoadingMode()
    {
        OperationQueue.main.addOperation {
            self.loadingCircle.removeFromSuperview()
            self.circle.removeFromSuperview()
        }
    }
    
    // MARK: - forgotpassword PopUp View method
    func createForgotPasswordPopUp() -> Void
    {
        self.viewForgotPasswordControlPop = UIControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.viewForgotPasswordControlPop.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
        viewForgotPasswordPop = UIView(frame: CGRect(x: 15, y: 0, width: self.viewForgotPasswordControlPop.frame.size.width - 30 , height:200))
        viewForgotPasswordPop.center = self.viewForgotPasswordControlPop.center
        viewForgotPasswordPop.backgroundColor=UIColor.white
        viewForgotPasswordPop.layer.cornerRadius = 4.0
        viewForgotPasswordPop.layer.masksToBounds = true
        self.viewForgotPasswordControlPop.addSubview(viewForgotPasswordPop)
        
        //--------- Text Input ----------------
        txtForgotEmailPop =  UITextField(frame: CGRect(x: 15, y: 15, width: viewForgotPasswordPop.frame.width-30, height: 44))
        txtForgotEmailPop.textAlignment = NSTextAlignment.left
        txtForgotEmailPop.backgroundColor = UIColor.white
        txtForgotEmailPop.delegate=self
        txtForgotEmailPop.placeholder="Email"
        txtForgotEmailPop.textColor=UIColor.darkGray
        txtForgotEmailPop.isSecureTextEntry=false
        txtForgotEmailPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtForgotEmailPop.frame.size.height - width, width: txtForgotEmailPop.frame.size.width, height: txtForgotEmailPop.frame.size.height)
        border.borderWidth = width
        txtForgotEmailPop.layer.addSublayer(border)
        txtForgotEmailPop.layer.masksToBounds = true
        viewForgotPasswordPop.addSubview(txtForgotEmailPop)
        
        self.view.addSubview(self.viewForgotPasswordControlPop)
    }
    @objc func pressCancelPop() -> Void
    {
        self.viewForgotPasswordControlPop.removeFromSuperview()
    }
    @objc func pressSavePop() -> Void
    {
        self.viewForgotPasswordControlPop.removeFromSuperview()
        
        if txtForgotEmailPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your email address", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.getForgotPasswordEmal(strEmail: txtForgotEmailPop.text!)
        }
    }
    
    //MARK: - get Login method
    func getLogin(strUsername:String,strPassword:String)
    {
        self.showLoadingMode()
        
        let parameters = ["StoreId": 1,"UserName":txtEmail.text as Any,"Password":txtPassword.text as Any] as [String : Any]
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/Login")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue(strapikey, forHTTPHeaderField: "apiSecretKey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                self.hideLoadingMode()
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    let dicUser = NSMutableDictionary(dictionary: dictemp)
                    
                    OperationQueue.main.addOperation{
                        
                        let strCustomerId = String(format: "%@", dicUser.value(forKey: "CustomerId") as! CVarArg)
                        UserDefaults.standard.set(strCustomerId, forKey: "CustomerId")
                        UserDefaults.standard.set(1, forKey: "AlreadyLogin")
                        
                        dicUser.setValue(self.txtPassword.text as Any, forKey: "Password")
                        UserDefaults.standard.set(dicUser, forKey: "CustomerDetails")
                        UserDefaults.standard.synchronize()
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch {
                //check for internal server data error
                self.hideLoadingMode()
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - get ForgotPassword method
    func getForgotPasswordEmal(strEmail:String)
    {
        self.showLoadingMode()
        
        let parameters = ["EmailId": txtForgotEmailPop.text as Any,"LanguageId":1] as [String : Any]
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/PasswordRecovery")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue(strapikey, forHTTPHeaderField: "apiSecretKey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                self.hideLoadingMode()
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    OperationQueue.main.addOperation{
                        let uiAlert = UIAlertController(title: "", message: "Your password has been succesfully sent to your email address", preferredStyle: UIAlertController.Style.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                    }
                }
            }
            catch {
                //check for internal server data error
                self.hideLoadingMode()
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
}
