//
//  ShippingMethod.swift
//  nopcommerce app
//
//  Created by Sandipan on 04/03/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class ShippingMethod: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{

    @IBOutlet var viewTopBar: UIView!
    @IBOutlet var btnBilling: UIButton!
    @IBOutlet var btnShipping: UIButton!
    @IBOutlet var btnDelivery: UIButton!
    @IBOutlet var btnPayment: UIButton!
    
    var selectedIndexPath: IndexPath?
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    @IBOutlet var colList: UICollectionView!
    var reuseIdentifier = "SMCell"
    
    var arrMShippingMethod = NSMutableArray()
    
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
        
        let layout = colList.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 160, height: 160)
        colList.register(UINib(nibName: "SMCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        //print(arrMShippingMethod.count)
        //print(arrMShippingMethod)
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: btnDelivery.frame.size.height - width, width: btnDelivery.frame.size.width, height: btnDelivery.frame.size.height)
        border.borderWidth = width
        btnDelivery.layer.addSublayer(border)
        btnDelivery.layer.masksToBounds = true
    }

    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any) {
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrMShippingMethod.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SMCell
        
        cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.masksToBounds = true
        
        if selectedIndexPath != nil && indexPath == selectedIndexPath {
            cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
            
        }else{
            
            cell.backgroundColor = UIColor.white
        }

        
        let dictemp: NSDictionary = arrMShippingMethod[indexPath.row] as! NSDictionary
        print(dictemp)
        
        let  str1 = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
        let  str2 = String(format: "%@", dictemp.value(forKey: "Fee") as! CVarArg)
        
        cell.lbl1.text = str1
        cell.lbl2.text = str2
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 5, left:5, bottom:5, right:5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! SMCell
        cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        self.selectedIndexPath = indexPath
        
        let dictemp: NSDictionary = arrMShippingMethod[indexPath.row] as! NSDictionary
        
        let  str1 = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
        let  str2 = String(format: "%@", dictemp.value(forKey: "ShippingRateComputationMethodSystemName") as! CVarArg)
        let  str3 = String(format: "%@___%@", str1,str2)
        
        print(str1)
        print(str2)
        print(str3)
        self.setShippingmethod(strShippingOption: str3)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell: SMCell = collectionView.cellForItem(at: indexPath) as! SMCell
        cell.backgroundColor = UIColor.white
        selectedIndexPath = nil
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
    
    //MARK: - set Shippingmethod method
    func setShippingmethod(strShippingOption:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CurrencyId":1,"ShippingOption":strShippingOption,"CustomerId":strcustomerid as Any] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/SelectShippingMethod")
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
                    
                    let dictt : NSDictionary = json
                    print(dictt)
                    
                    let arrm1 :NSArray =  json.value(forKey: "PaymentMethods") as! NSArray
                    
                    OperationQueue.main.addOperation {
                        
                        let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
                        let PaymentMethod = storyBoard.instantiateViewController(withIdentifier: "PaymentMethod") as! PaymentMethod
                        PaymentMethod.arrMPaymentMethod = NSMutableArray(array: arrm1)
                        PaymentMethod.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(PaymentMethod, animated: false)
                        
                        /*let screenSize = UIScreen.main.bounds
                        if (screenSize.height == 568.0){
                        }
                        else if (screenSize.height == 480.0){
                        }
                        else if(screenSize.height == 667.0){
                            let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
                            let PaymentMethod = storyBoard.instantiateViewController(withIdentifier: "PaymentMethod") as! PaymentMethod
                            PaymentMethod.arrMPaymentMethod = NSMutableArray(array: arrm1)
                            PaymentMethod.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(PaymentMethod, animated: false)
                        }
                        else if(screenSize.height == 736.0){
                            let storyBoard = UIStoryboard(name: "SectionThree6SPlus", bundle: nil)
                            let PaymentMethod = storyBoard.instantiateViewController(withIdentifier: "PaymentMethod") as! PaymentMethod
                            PaymentMethod.arrMPaymentMethod = NSMutableArray(array: arrm1)
                            PaymentMethod.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(PaymentMethod, animated: false)
                        }
                        else if(screenSize.height == 812.0){
                            let storyBoard = UIStoryboard(name: "SectionThreeXS", bundle: nil)
                            let PaymentMethod = storyBoard.instantiateViewController(withIdentifier: "PaymentMethod") as! PaymentMethod
                            PaymentMethod.arrMPaymentMethod = NSMutableArray(array: arrm1)
                            PaymentMethod.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(PaymentMethod, animated: false)
                        }
                        else{
                            let storyBoard = UIStoryboard(name: "SectionThreeXSMAX", bundle: nil)
                            let PaymentMethod = storyBoard.instantiateViewController(withIdentifier: "PaymentMethod") as! PaymentMethod
                            PaymentMethod.arrMPaymentMethod = NSMutableArray(array: arrm1)
                            PaymentMethod.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(PaymentMethod, animated: false)
                        }*/
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
