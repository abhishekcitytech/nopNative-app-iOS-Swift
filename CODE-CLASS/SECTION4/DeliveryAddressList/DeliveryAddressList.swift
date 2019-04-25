//
//  DeliveryAddressList.swift
//  nopcommerce app
//
//  Created by Sandipan on 29/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class DeliveryAddressList: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    var loadingCircle = UIView()
    var circle = UIView()
    
    @IBOutlet var btnAddNewAddress: UIButton!
    
    var viewAddessControlPop = UIControl()
    var viewAddressPop = UIView()
    var txtAddressNamePop = UITextField()
    var txtAddressStreet1Pop = UITextField()
    var txtAddressStreet2Pop = UITextField()
    var txtAddressCityPop = UITextField()
    var txtAddressZipPop = UITextField()
    var txtAddressEmailPop = UITextField()
    var txtAddressMobilenoPop = UITextField()
    var btnAddressCancelPop = UIButton()
    var btnAddressSavePop = UIButton()
    
    @IBOutlet var tabvAddress: UITableView!
    let cellReuseIdentifier = "cell"
    var stridentifer = NSString()
    
    var arrMAddressList = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        self.getAddAddressList()
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
        
        tabvAddress.backgroundView=nil
        tabvAddress.backgroundColor=UIColor.clear
        tabvAddress.separatorColor=UIColor.clear
        tabvAddress.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
    }

    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
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
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMAddressList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        
        let dictemp: NSDictionary = arrMAddressList[indexPath.row] as! NSDictionary
        
        let  strFirstName = String(format: "%@", dictemp.value(forKey: "FirstName") as! CVarArg)
        let  strLastName = String(format: "%@", dictemp.value(forKey: "LastName") as! CVarArg)
        let  strAddress1 = String(format: "%@", dictemp.value(forKey: "Address1") as! CVarArg)
        let  strAddress2 = String(format: "%@", dictemp.value(forKey: "Address2") as! CVarArg)
        let  strCity = String(format: "%@", dictemp.value(forKey: "City") as! CVarArg)
        let  strZipPostalCode = String(format: "%@", dictemp.value(forKey: "ZipPostalCode") as! CVarArg)
        let  strPhoneNumber = String(format: "%@", dictemp.value(forKey: "PhoneNumber") as! CVarArg)
        
        
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: tabvAddress.frame.size.width, height: 25))
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.numberOfLines=1;
        label.text = String(format: "%@ %@", strFirstName,strLastName)
        label.font = UIFont(name: "Dubai-Medium", size: 18.0)!
        cell.contentView.addSubview(label)
        
        let label1 = UILabel(frame: CGRect(x: 15, y: label.frame.maxY, width: tabvAddress.frame.size.width, height:40))
        label1.text = String(format: "%@,%@,%@,%@", strAddress1,strAddress2,strCity,strZipPostalCode)
        label1.textAlignment = .left
        label1.numberOfLines = 2
        label1.textColor = UIColor.darkGray
        label1.backgroundColor = UIColor.clear
        label1.font = UIFont(name: "Dubai-Regular", size: 14.0)!
        cell.contentView.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 15, y: label1.frame.maxY, width: tabvAddress.frame.size.width, height:30))
        label2.text = String(format: "%@", strPhoneNumber)
        label2.textAlignment = .left
        label2.textColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
        label2.backgroundColor = UIColor.clear
        label2.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        cell.contentView.addSubview(label2)
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 109.5, width: tableView.frame.size.width, height: 0.5))
        labelSeparator.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0)
        cell.contentView.addSubview(labelSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    // MARK: - press AddNewAddress method
    @IBAction func pressAddNewAddress(_ sender: Any)
    {
        self.createAddNewAddressPopUp()
    }
    
    // MARK: - AddNewAddress PopUp View method
    func createAddNewAddressPopUp() -> Void
    {
        self.viewAddessControlPop = UIControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        self.viewAddessControlPop.backgroundColor=UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
        viewAddressPop = UIView(frame: CGRect(x: 15, y: 0, width: self.viewAddessControlPop.frame.size.width - 30 , height:self.viewAddessControlPop.frame.size.height / 2 + 80))
        viewAddressPop.center = self.viewAddessControlPop.center
        viewAddressPop.backgroundColor=UIColor.white
        viewAddressPop.layer.cornerRadius = 4.0
        viewAddressPop.layer.masksToBounds = true
        self.viewAddessControlPop.addSubview(viewAddressPop)
        
        //--------- Text Input ----------------
        txtAddressNamePop =  UITextField(frame: CGRect(x: 15, y: 15, width: viewAddressPop.frame.width-30, height: 44))
        txtAddressNamePop.textAlignment = NSTextAlignment.left
        txtAddressNamePop.backgroundColor = UIColor.white
        txtAddressNamePop.delegate=self
        txtAddressNamePop.placeholder="Name"
        txtAddressNamePop.textColor=UIColor.darkGray
        txtAddressNamePop.isSecureTextEntry=false
        txtAddressNamePop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: txtAddressNamePop.frame.size.height - width, width: txtAddressNamePop.frame.size.width, height: txtAddressNamePop.frame.size.height)
        border.borderWidth = width
        txtAddressNamePop.layer.addSublayer(border)
        txtAddressNamePop.layer.masksToBounds = true
        
        viewAddressPop.addSubview(txtAddressNamePop)
        
        txtAddressStreet1Pop =  UITextField(frame: CGRect(x: 15, y: txtAddressNamePop.frame.maxY + 2, width: viewAddressPop.frame.width-30, height: 44))
        txtAddressStreet1Pop.textAlignment = NSTextAlignment.left
        txtAddressStreet1Pop.backgroundColor = UIColor.white
        txtAddressStreet1Pop.delegate=self
        txtAddressStreet1Pop.placeholder="Street 1"
        txtAddressStreet1Pop.textColor=UIColor.darkGray
        txtAddressStreet1Pop.isSecureTextEntry=false
        txtAddressStreet1Pop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        
        let border1 = CALayer()
        let width1 = CGFloat(0.5)
        border1.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border1.frame = CGRect(x: 0, y: txtAddressStreet1Pop.frame.size.height - width1, width: txtAddressStreet1Pop.frame.size.width, height: txtAddressStreet1Pop.frame.size.height)
        border1.borderWidth = width1
        txtAddressStreet1Pop.layer.addSublayer(border1)
        txtAddressStreet1Pop.layer.masksToBounds = true
        
        viewAddressPop.addSubview(txtAddressStreet1Pop)
        
        txtAddressStreet2Pop =  UITextField(frame: CGRect(x: 15, y: txtAddressStreet1Pop.frame.maxY + 2, width: viewAddressPop.frame.width-30, height: 44))
        txtAddressStreet2Pop.textAlignment = NSTextAlignment.left
        txtAddressStreet2Pop.backgroundColor = UIColor.white
        txtAddressStreet2Pop.delegate=self
        txtAddressStreet2Pop.placeholder="Street 2"
        txtAddressStreet2Pop.textColor=UIColor.darkGray
        txtAddressStreet2Pop.isSecureTextEntry=false
        txtAddressStreet2Pop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        
        let border2 = CALayer()
        let width2 = CGFloat(0.5)
        border2.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border2.frame = CGRect(x: 0, y: txtAddressStreet2Pop.frame.size.height - width2, width: txtAddressStreet2Pop.frame.size.width, height: txtAddressStreet2Pop.frame.size.height)
        border2.borderWidth = width2
        txtAddressStreet2Pop.layer.addSublayer(border2)
        txtAddressStreet2Pop.layer.masksToBounds = true
        
        viewAddressPop.addSubview(txtAddressStreet2Pop)
        
        txtAddressCityPop =  UITextField(frame: CGRect(x: 15, y: txtAddressStreet2Pop.frame.maxY + 2, width: viewAddressPop.frame.width-30, height: 44))
        txtAddressCityPop.textAlignment = NSTextAlignment.left
        txtAddressCityPop.backgroundColor = UIColor.white
        txtAddressCityPop.delegate=self
        txtAddressCityPop.placeholder="City"
        txtAddressCityPop.textColor=UIColor.darkGray
        txtAddressCityPop.isSecureTextEntry=false
        txtAddressCityPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        
        let border3 = CALayer()
        let width3 = CGFloat(0.5)
        border3.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border3.frame = CGRect(x: 0, y: txtAddressCityPop.frame.size.height - width3, width: txtAddressCityPop.frame.size.width, height: txtAddressCityPop.frame.size.height)
        border3.borderWidth = width3
        txtAddressCityPop.layer.addSublayer(border3)
        txtAddressCityPop.layer.masksToBounds = true
        
        viewAddressPop.addSubview(txtAddressCityPop)
        
        txtAddressZipPop =  UITextField(frame: CGRect(x: 15, y: txtAddressCityPop.frame.maxY + 2, width: viewAddressPop.frame.width-30, height: 44))
        txtAddressZipPop.textAlignment = NSTextAlignment.left
        txtAddressZipPop.backgroundColor = UIColor.white
        txtAddressZipPop.delegate=self
        txtAddressZipPop.placeholder="Zip Code"
        txtAddressZipPop.textColor=UIColor.darkGray
        txtAddressZipPop.isSecureTextEntry=false
        txtAddressZipPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        
        let border4 = CALayer()
        let width4 = CGFloat(0.5)
        border4.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border4.frame = CGRect(x: 0, y: txtAddressZipPop.frame.size.height - width4, width: txtAddressZipPop.frame.size.width, height: txtAddressZipPop.frame.size.height)
        border4.borderWidth = width4
        txtAddressZipPop.layer.addSublayer(border4)
        txtAddressZipPop.layer.masksToBounds = true
        
        viewAddressPop.addSubview(txtAddressZipPop)
        
        txtAddressEmailPop =  UITextField(frame: CGRect(x: 15, y: txtAddressZipPop.frame.maxY + 2, width: viewAddressPop.frame.width-30, height: 44))
        txtAddressEmailPop.textAlignment = NSTextAlignment.left
        txtAddressEmailPop.backgroundColor = UIColor.white
        txtAddressEmailPop.delegate=self
        txtAddressEmailPop.placeholder="Email"
        txtAddressEmailPop.textColor=UIColor.darkGray
        txtAddressEmailPop.isSecureTextEntry=false
        txtAddressEmailPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        
        let border5 = CALayer()
        let width5 = CGFloat(0.5)
        border5.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border5.frame = CGRect(x: 0, y: txtAddressEmailPop.frame.size.height - width5, width: txtAddressEmailPop.frame.size.width, height: txtAddressEmailPop.frame.size.height)
        border5.borderWidth = width5
        txtAddressEmailPop.layer.addSublayer(border5)
        txtAddressEmailPop.layer.masksToBounds = true
        
        viewAddressPop.addSubview(txtAddressEmailPop)
        
        txtAddressMobilenoPop =  UITextField(frame: CGRect(x: 15, y: txtAddressEmailPop.frame.maxY + 2, width: viewAddressPop.frame.width-30, height: 44))
        txtAddressMobilenoPop.textAlignment = NSTextAlignment.left
        txtAddressMobilenoPop.backgroundColor = UIColor.white
        txtAddressMobilenoPop.delegate=self
        txtAddressMobilenoPop.placeholder="Mobile Number"
        txtAddressMobilenoPop.textColor=UIColor.darkGray
        txtAddressMobilenoPop.isSecureTextEntry=false
        txtAddressMobilenoPop.font = UIFont(name: "Dubai-Regular", size: 16.0)!
        
        let border6 = CALayer()
        let width6 = CGFloat(0.5)
        border6.borderColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0).cgColor
        border6.frame = CGRect(x: 0, y: txtAddressMobilenoPop.frame.size.height - width6, width: txtAddressMobilenoPop.frame.size.width, height: txtAddressMobilenoPop.frame.size.height)
        border6.borderWidth = width6
        txtAddressMobilenoPop.layer.addSublayer(border6)
        txtAddressMobilenoPop.layer.masksToBounds = true
        
        viewAddressPop.addSubview(txtAddressMobilenoPop)
        
        //--------- Cancel & Save ----------------
        btnAddressCancelPop = UIButton(frame: CGRect(x: 0, y: viewAddressPop.frame.size.height-50, width: viewAddressPop.frame.size.width / 2, height: 50))
        btnAddressCancelPop.setTitle("Cancel", for: .normal)
        btnAddressCancelPop.setTitleColor(UIColor.red, for: .normal)
        btnAddressCancelPop.titleLabel?.font = UIFont(name: "Dubai-Medium", size: 18.0)!
        btnAddressCancelPop.tag=1
        btnAddressCancelPop.addTarget(self, action: #selector(pressCancelPop), for: .touchUpInside)
        btnAddressCancelPop.layer.borderWidth = 1.0
        btnAddressCancelPop.layer.borderColor = UIColor.lightGray.cgColor
        btnAddressCancelPop.layer.cornerRadius = 0.0
        btnAddressCancelPop.layer.masksToBounds = true
        btnAddressCancelPop.backgroundColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        viewAddressPop.addSubview(btnAddressCancelPop)
        
        btnAddressSavePop = UIButton(frame: CGRect(x: btnAddressCancelPop.frame.maxX, y: viewAddressPop.frame.size.height-50, width: viewAddressPop.frame.size.width / 2, height: 50))
        btnAddressSavePop.setTitle("Save", for: .normal)
        btnAddressSavePop.setTitleColor(UIColor.black, for: .normal)
        btnAddressSavePop.titleLabel?.font = UIFont(name: "Dubai-Medium", size: 18.0)!
        btnAddressSavePop.tag=2
        btnAddressSavePop.addTarget(self, action: #selector(pressSavePop), for: .touchUpInside)
        btnAddressSavePop.layer.borderWidth = 1.0
        btnAddressSavePop.layer.borderColor = UIColor.lightGray.cgColor
        btnAddressSavePop.layer.cornerRadius = 0.0
        btnAddressSavePop.layer.masksToBounds = true
        btnAddressSavePop.backgroundColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        viewAddressPop.addSubview(btnAddressSavePop)
        
        self.view.addSubview(self.viewAddessControlPop)
    }
    @objc func pressCancelPop() -> Void
    {
        self.viewAddessControlPop.removeFromSuperview()
    }
    @objc func pressSavePop() -> Void
    {
        self.viewAddessControlPop.removeFromSuperview()
        
        if txtAddressNamePop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtAddressStreet1Pop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter address1", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtAddressStreet2Pop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter address2", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtAddressCityPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter city", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtAddressZipPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter zip code", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtAddressEmailPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter email", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtAddressMobilenoPop.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter mobile no", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.postAddAddress(strFirstName: txtAddressNamePop.text!, strLastName: txtAddressNamePop.text!, strEmail: txtAddressEmailPop.text!, strCity: txtAddressCityPop.text!, strAddress1: txtAddressStreet1Pop.text!, strAddress2: txtAddressStreet2Pop.text!, strZipPostalCode: txtAddressZipPop.text!, strPhoneNumber: txtAddressMobilenoPop.text!)
        }
        
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
    
    
    //MARK: - post AddDeliveryAddress method
    func postAddAddress(strFirstName:String,strLastName:String,strEmail:String,strCity:String,strAddress1:String,strAddress2:String,
                        strZipPostalCode:String,strPhoneNumber:String)
    {
        
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["CustomerId": strcustomerid as Any,"LanguageId":1,"FirstName":strFirstName as Any,"LastName":strLastName as Any,"Email":strEmail as Any,"Company":"","CountryId":1,"StateProvinceId":0,"City":strCity as Any,"Address1":strAddress1 as Any,"Address2":strAddress2 as Any,"ZipPostalCode":strZipPostalCode as Any,"PhoneNumber":strPhoneNumber as Any,"FaxNumber":"","AddressId":0] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/AddAddress")
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
                        self.getAddAddressList()
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
    
    //MARK: - get AddAddressList method
    func getAddAddressList()
    {
        
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["CustomerId": strcustomerid as Any,"StoreId":1] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/GetAddress")
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
                    
                    let arrm1 :NSArray =  json.value(forKey: "Addresses") as! NSArray
                    self.arrMAddressList = NSMutableArray(array: arrm1)
                    print("self.arrMAddressList --->",self.arrMAddressList)
                    
                    
                    OperationQueue.main.addOperation {
                        if self.arrMAddressList.count > 0{
                            self.tabvAddress.reloadData()
                        }
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
