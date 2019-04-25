//
//  Registration.swift
//  nopcommerce app
//
//  Created by Sandipan on 18/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class Registration: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet var viewBox: UIView!
    @IBOutlet var txtFirstname: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtLastname: UITextField!
    @IBOutlet var txtMobileNumber: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    
    @IBOutlet var segGender: UISegmentedControl!
    @IBOutlet var txtDOB: UITextField!
    @IBOutlet var btnDOB: UIButton!
    
    @IBOutlet var lblNewsLetter: UILabel!
    @IBOutlet var btnNewsLetter: UIButton!
    
    @IBOutlet var btnRegister: UIButton!
    
    
    var strNewsLetter = String()
    var strGender = String()
    
    let dateFormatter = DateFormatter()
    let locale = NSLocale.current
    var viewDatePicker = UIView()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    
    var loadingCircle = UIView()
    var circle = UIView()
    
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

        btnRegister.layer.borderColor = UIColor.clear.cgColor
        btnRegister.layer.borderWidth = 1.0
        btnRegister.layer.cornerRadius = 2.0
        btnRegister.layer.masksToBounds = true
        
        btnNewsLetter.tag = 0
        btnNewsLetter.isSelected = false
    }
    

    // MARK: - press Back method
    @IBAction func pressBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - press SegGender method
    @IBAction func pressSegGender(_ sender: Any)
    {
        if segGender.selectedSegmentIndex == 0 {
            //Male
            strGender = "Male"
        }
        else{
            //Female
            strGender = "Female"
        }
    }
    
    // MARK: - press DOB method
    @IBAction func pressDOB(_ sender: Any)
    {
        self.doDatePicker()
    }
    func doDatePicker()
    {
        viewDatePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300 , width: UIScreen.main.bounds.size.width, height: 250)
        viewDatePicker.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
        viewDatePicker.layer.borderColor = UIColor.lightGray.cgColor
        viewDatePicker.layer.borderWidth = 1.0
        viewDatePicker.layer.masksToBounds = true
        self.view.addSubview(self.viewDatePicker)
        
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 50 , width: viewDatePicker.frame.size.width, height: 200))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        viewDatePicker.addSubview(self.datePicker)
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "Dubai-Medium", size: 16.0)!
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.addTarget(self, action: #selector(dismissPicker), for: .touchUpInside)
        doneButton.frame = CGRect(x: viewDatePicker.frame.maxX - 80, y: 0, width: 80, height: 50)
        viewDatePicker.addSubview(doneButton)
        
        // add an event called when value is changed.
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)

    }
    @objc func datePickerValueChanged(sender:UIDatePicker)
    {
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd"
        let mySelectedDate: NSString = myDateFormatter.string(from: sender.date) as NSString
        txtDOB.text = mySelectedDate as String
        
        //self.viewDatePicker.removeFromSuperview()
    }
    @objc func dismissPicker(sender: UIButton)
    {
        self.viewDatePicker.removeFromSuperview()
    }
    
    
    // MARK: - press NewsLetter method
    @IBAction func pressNewsLetter(_ sender: Any)
    {
        if btnNewsLetter.isSelected == false
        {
            btnNewsLetter.tag = 1
            btnNewsLetter.isSelected = true
        }
        else
        {
            btnNewsLetter.tag = 0
            btnNewsLetter.isSelected = false
        }
    }
    
    //MARK: - pressRegister Method
    @IBAction func pressRegister(_ sender: Any)
    {
        if txtFirstname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter first name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtLastname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter last name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtEmail.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter email", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtMobileNumber.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter mobile number", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtConfirmPassword.text == "" ||  txtPassword.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter password", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtDOB.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please choose date of birth", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.getRegister()
        }
        
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
    
    
    //MARK: - get Register method
    func getRegister()
    {
        self.showLoadingMode()
        
        if btnNewsLetter.tag == 0
        {
            strNewsLetter = "false"
        }
        else{
            strNewsLetter = "true"
        }
        
        let parameters = ["StoreId": 1,"UserName":txtEmail.text as Any,"EmailId":txtEmail.text as Any,"Password":txtPassword.text as Any,"Gender":strGender,"LanguageId":1,"FirstName":txtFirstname.text as Any,"LastName":txtLastname.text as Any,"DateOfBirth":txtDOB.text as Any,"CompanyName":"","PhoneNumber":txtMobileNumber.text as Any,"NewsLetter":strNewsLetter,"IsGuestCustomerId":0] as [String : Any]
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/Register")
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
                    
                    let strCustomerId = String(format: "%@", dictemp.value(forKey: "CustomerId") as! CVarArg)
                    if strCustomerId != ""
                    {
                        //Success
                        
                        UserDefaults.standard.set(strCustomerId, forKey: "CustomerId")
                        UserDefaults.standard.synchronize()
                        
                        OperationQueue.main.addOperation{
                            self.getLogin(strUsername: self.txtEmail.text!, strPassword: self.txtPassword.text!)
                        }
                    }
                    else
                    {
                        //Not cmpleted
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
                    
                    let strCustomerId = String(format: "%@", dicUser.value(forKey: "CustomerId") as! CVarArg)
                    
                    
                    UserDefaults.standard.set(strCustomerId, forKey: "CustomerId")
                    UserDefaults.standard.set(1, forKey: "AlreadyLogin")
                    UserDefaults.standard.set(dicUser, forKey: "CustomerDetails")
                    UserDefaults.standard.synchronize()
                    
                    OperationQueue.main.addOperation{
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
    
}
