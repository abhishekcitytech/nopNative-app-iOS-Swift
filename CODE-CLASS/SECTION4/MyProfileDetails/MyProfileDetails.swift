//
//  MyProfileDetails.swift
//  nopcommerce app
//
//  Created by Sandipan on 29/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class MyProfileDetails: UIViewController, UITextFieldDelegate
{
    var loadingCircle = UIView()
    var circle = UIView()
    
    @IBOutlet var viewBox: UIView!
    @IBOutlet var txtFirstname: UITextField!
    @IBOutlet var txtLastname: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtMobileNumber: UITextField!
    @IBOutlet var segGender: UISegmentedControl!
    @IBOutlet var txtDOB: UITextField!
    @IBOutlet var btnDOB: UIButton!
    
    var strGender = String()
    
    @IBOutlet var btnChangePassword: UIButton!
    var viewChangePasswordControlPop = UIControl()
    var viewCRPop = UIView()
    var txtCREmailPop = UITextField()
    var txtCROldPop = UITextField()
    var txtCRNewPop = UITextField()
    var btnCRCancelPop = UIButton()
    var btnCRSavePop = UIButton()
    
    @IBOutlet var btnEditUpdate: UIButton!
    
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
        
        btnEditUpdate.tag = 0
        btnEditUpdate.setTitle("Edit", for: .normal)
        
        let dicUser = UserDefaults.standard.value(forKey: "CustomerDetails") as! NSMutableDictionary
        print(dicUser)
        let  str1 = String(format: "%@", dicUser.value(forKey: "FirstName") as! CVarArg)
        let  str2 = String(format: "%@", dicUser.value(forKey: "LastName") as! CVarArg)
        let  str3 = String(format: "%@", dicUser.value(forKey: "EmailId") as! CVarArg)
        let  str4 = String(format: "%@", dicUser.value(forKey: "Phone") as! CVarArg)
        
        let  str5 = String(format: "%@", dicUser.value(forKey: "Gender") as! CVarArg)
        let  str6 = String(format: "%@", dicUser.value(forKey: "DateOfBirth") as! CVarArg)
        
        txtFirstname.text = str1
        txtLastname.text = str2
        txtEmail.text = str3
        txtMobileNumber.text = str4
        txtDOB.text = str6
        if str5 == "Male" {
            segGender.selectedSegmentIndex = 0
            strGender = "M"
        }
        else{
            segGender.selectedSegmentIndex = 1
            strGender = "F"
        }
        
        
        txtFirstname.isUserInteractionEnabled = false
        txtLastname.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
        txtMobileNumber.isUserInteractionEnabled = false
        txtDOB.isUserInteractionEnabled = false
        btnDOB.isUserInteractionEnabled = false
        segGender.isUserInteractionEnabled = false
    }

    // MARK: - press Back method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - press SegGender method
    @IBAction func pressSegGender(_ sender: Any)
    {
        if segGender.selectedSegmentIndex == 0 {
            //Male
            strGender = "M"
        }
        else{
            //Female
            strGender = "F"
        }
    }
    
    // MARK: - press DOB method
    @IBAction func pressDOB(_ sender: Any)
    {
        //self.doDatePicker()
    }
    
    // MARK: - press EditUpdate method
    @IBAction func pressEditUpdate(_ sender: UIButton)
    {
        if sender.tag == 0 {
            //Please edit all fields and update the value
            btnEditUpdate.tag = 1
            btnEditUpdate.setTitle("Save", for: .normal)
            
            txtFirstname.isUserInteractionEnabled = true
            txtLastname.isUserInteractionEnabled = true
            txtEmail.isUserInteractionEnabled = true
            txtMobileNumber.isUserInteractionEnabled = false
            txtDOB.isUserInteractionEnabled = false
            btnDOB.isUserInteractionEnabled = false
            segGender.isUserInteractionEnabled = true
        }
        else{
            
            //Please POST all updated information
            print(txtFirstname.text as Any)
            print(txtLastname.text as Any)
            print(txtEmail.text as Any)
            print(txtMobileNumber.text as Any)
            print(segGender.selectedSegmentIndex)
            
            self.postCustomerInfo(strfirstname: txtFirstname.text!, strlastname: txtLastname.text!, stremail: txtEmail.text!, strmobilenumber: txtMobileNumber.text!, strgender: strGender, strdob: txtDOB.text!)
        }
    }
    
    
    // MARK: - press ChangePassword method
    @IBAction func pressChangePassword(_ sender: Any)
    {
        self.createChangePasswordPopUp()
    }
    
    // MARK: - create ChangePassword PopUp View method
    func createChangePasswordPopUp() -> Void
    {
        self.viewChangePasswordControlPop = UIControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.viewChangePasswordControlPop.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
        viewCRPop = UIView(frame: CGRect(x: 15, y: 0, width: self.viewChangePasswordControlPop.frame.size.width - 30 , height:250))
        viewCRPop.center = self.viewChangePasswordControlPop.center
        viewCRPop.backgroundColor=UIColor.white
        viewCRPop.layer.cornerRadius = 4.0
        viewCRPop.layer.masksToBounds = true
        self.viewChangePasswordControlPop.addSubview(viewCRPop)
        
        let dicUser = UserDefaults.standard.value(forKey: "CustomerDetails") as! NSMutableDictionary
        print(dicUser)
        let  str3 = String(format: "%@", dicUser.value(forKey: "EmailId") as! CVarArg)
        
        txtCREmailPop =  UITextField(frame: CGRect(x: 15, y: 15, width: viewCRPop.frame.width-30, height: 44))
        txtCREmailPop.textAlignment = NSTextAlignment.left
        txtCREmailPop.backgroundColor = UIColor.white
        txtCREmailPop.delegate=self
        txtCREmailPop.placeholder="Email"
        txtCREmailPop.textColor=UIColor.darkGray
        txtCREmailPop.isSecureTextEntry=false
        txtCREmailPop.text = str3
        txtCREmailPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        txtCREmailPop.isUserInteractionEnabled = false
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtCREmailPop.frame.size.height - width, width: txtCREmailPop.frame.size.width, height: txtCREmailPop.frame.size.height)
        border.borderWidth = width
        txtCREmailPop.layer.addSublayer(border)
        txtCREmailPop.layer.masksToBounds = true
        viewCRPop.addSubview(txtCREmailPop)
        
        txtCROldPop =  UITextField(frame: CGRect(x: 15, y: txtCREmailPop.frame.maxY + 2, width: viewCRPop.frame.width-30, height: 44))
        txtCROldPop.textAlignment = NSTextAlignment.left
        txtCROldPop.backgroundColor = UIColor.white
        txtCROldPop.delegate=self
        txtCROldPop.placeholder="Old password"
        txtCROldPop.textColor=UIColor.darkGray
        txtCROldPop.isSecureTextEntry=true
        txtCROldPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        let border1 = CALayer()
        let width1 = CGFloat(0.5)
        border1.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtCROldPop.frame.size.height - width1, width: txtCROldPop.frame.size.width, height: txtCROldPop.frame.size.height)
        border1.borderWidth = width1
        txtCROldPop.layer.addSublayer(border1)
        txtCROldPop.layer.masksToBounds = true
        viewCRPop.addSubview(txtCROldPop)
        
        txtCRNewPop =  UITextField(frame: CGRect(x: 15, y: txtCROldPop.frame.maxY + 2, width: viewCRPop.frame.width-30, height: 44))
        txtCRNewPop.textAlignment = NSTextAlignment.left
        txtCRNewPop.backgroundColor = UIColor.white
        txtCRNewPop.delegate=self
        txtCRNewPop.placeholder="New password"
        txtCRNewPop.textColor=UIColor.darkGray
        txtCRNewPop.isSecureTextEntry=true
        txtCRNewPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        let border2 = CALayer()
        let width2 = CGFloat(0.5)
        border2.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border2.frame = CGRect(x: 0, y: txtCRNewPop.frame.size.height - width2, width: txtCRNewPop.frame.size.width, height: txtCRNewPop.frame.size.height)
        border2.borderWidth = width2
        txtCRNewPop.layer.addSublayer(border2)
        txtCRNewPop.layer.masksToBounds = true
        viewCRPop.addSubview(txtCRNewPop)
        
        //--------- Cancel & Save ----------------
        btnCRCancelPop = UIButton(frame: CGRect(x: 0, y: viewCRPop.frame.size.height-50, width: viewCRPop.frame.size.width / 2, height: 50))
        btnCRCancelPop.setTitle("Cancel", for: .normal)
        btnCRCancelPop.setTitleColor(UIColor.red, for: .normal)
        btnCRCancelPop.titleLabel?.font = UIFont(name: "Dubai-Medium", size: 18.0)!
        btnCRCancelPop.tag=1
        btnCRCancelPop.addTarget(self, action: #selector(pressCancelPop), for: .touchUpInside)
        btnCRCancelPop.layer.borderWidth = 1.0
        btnCRCancelPop.layer.borderColor = UIColor.lightGray.cgColor
        btnCRCancelPop.layer.cornerRadius = 0.0
        btnCRCancelPop.layer.masksToBounds = true
        btnCRCancelPop.backgroundColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        viewCRPop.addSubview(btnCRCancelPop)
        
        btnCRSavePop = UIButton(frame: CGRect(x: btnCRCancelPop.frame.maxX, y: viewCRPop.frame.size.height-50, width: viewCRPop.frame.size.width / 2, height: 50))
        btnCRSavePop.setTitle("Save", for: .normal)
        btnCRSavePop.setTitleColor(UIColor.black, for: .normal)
        btnCRSavePop.titleLabel?.font = UIFont(name: "Dubai-Medium", size: 18.0)!
        btnCRSavePop.tag=2
        btnCRSavePop.addTarget(self, action: #selector(pressSavePop), for: .touchUpInside)
        btnCRSavePop.layer.borderWidth = 1.0
        btnCRSavePop.layer.borderColor = UIColor.lightGray.cgColor
        btnCRSavePop.layer.cornerRadius = 0.0
        btnCRSavePop.layer.masksToBounds = true
        btnCRSavePop.backgroundColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        viewCRPop.addSubview(btnCRSavePop)
        
        self.view.addSubview(self.viewChangePasswordControlPop)
    }
    @objc func pressCancelPop() -> Void
    {
        self.viewChangePasswordControlPop.removeFromSuperview()
    }
    @objc func pressSavePop() -> Void
    {
        self.viewChangePasswordControlPop.removeFromSuperview()
        
        if txtCREmailPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your email", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtCROldPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter old password", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtCRNewPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter new password", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.postChangePassword(strEmail: txtCREmailPop.text!, strOld: txtCROldPop.text!, strNew: txtCRNewPop.text!)
        }
    }
    
    //MARK: - post ChangePassword method
    func postChangePassword(strEmail:String,strOld:String,strNew:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        
        let parameters = ["EmailId": strEmail as Any,"OldPassword":strOld as Any,"NewPassword":strNew as Any] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/ChangePassword")
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
                    
                    OperationQueue.main.addOperation {
                        
                        var dicUser = UserDefaults.standard.value(forKey: "CustomerDetails") as! NSMutableDictionary
                        print(dicUser)
                        
                        let dicUser2 = dicUser.mutableCopy() as! NSMutableDictionary
                        dicUser2.setObject(self.txtCRNewPop.text as Any, forKey: "Password" as NSCopying)
                        dicUser = dicUser2.mutableCopy() as! NSMutableDictionary
                        print(dicUser)
                        
                        UserDefaults.standard.set(dicUser, forKey: "CustomerDetails")
                        UserDefaults.standard.synchronize()
                        
                        let dicUser1 = UserDefaults.standard.value(forKey: "CustomerDetails") as! NSMutableDictionary
                        print(dicUser1)
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
    
    //MARK: - post CustomerInfo method
    func postCustomerInfo(strfirstname:String,strlastname:String,stremail:String,strmobilenumber:String,strgender:String,strdob:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CustomerId": strcustomerid as Any,"CompanyName":"","Gender":strgender,"FirstName":strfirstname,"LastName":strlastname,"Email":stremail,"DateOfBirth":strdob] as [String : Any]
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/InfoEdit")
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

                    OperationQueue.main.addOperation{
                        self.btnEditUpdate.tag = 0
                        self.btnEditUpdate.setTitle("Edit", for: .normal)
                        
                        self.txtFirstname.isUserInteractionEnabled = false
                        self.txtLastname.isUserInteractionEnabled = false
                        self.txtEmail.isUserInteractionEnabled = false
                        self.txtMobileNumber.isUserInteractionEnabled = false
                        self.txtDOB.isUserInteractionEnabled = false
                        self.btnDOB.isUserInteractionEnabled = false
                        self.segGender.isUserInteractionEnabled = false
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
    
}
