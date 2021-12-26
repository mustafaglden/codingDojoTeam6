//
//  ViewController.swift
//  codingDojo
//
//  Created by Mustafa Gülden on 26.12.2021.
//

import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class ViewController: UIViewController {

    let outputLabel = UILabel()
    let eMail = UITextField()
    let oncelik = UISwitch()
    let button = UIButton()
    let message = UITextField()
    let _title = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(rgb: 0x225456)
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        _title.text = "Team VI"
        _title.textColor = .white
        _title.textAlignment = .center
        _title.font = .boldSystemFont(ofSize: 30)
        
        eMail.textColor = .black
        eMail.backgroundColor = UIColor(rgb: 0xa4ccca)
        eMail.textAlignment = NSTextAlignment.center
        eMail.text = nil
        eMail.placeholder = "E Mail Giriniz."
        
        message.backgroundColor = UIColor(rgb: 0xa4ccca)
        message.textColor = .black
        message.text = nil
        message.textAlignment = .center
        message.placeholder = "Mesaj Giriniz"

        outputLabel.backgroundColor = UIColor(rgb: 0xa4ccca)
        outputLabel.textColor = .black
        outputLabel.numberOfLines = 0
               
        _title.frame = CGRect(x: (width * 0.5) - 150, y: (height * 0.5) - 300, width: 300, height: 50)
        eMail.frame = CGRect(x: (width * 0.5) - 150, y: (height * 0.5) - 250, width: 300, height: 50)
        message.frame = CGRect(x: (width * 0.5) - 150, y: (height * 0.5) - 180, width: 300, height: 200)
        outputLabel.frame = CGRect(x: (width * 0.5) - 150, y: (height * 0.5) + 160, width: 300, height: 200)
        oncelik.frame = CGRect(x: (width * 0.5) - 150, y: (height * 0.5) + 120, width: 300, height: 20)
        button.frame = CGRect(x: (width * 0.5) - 150, y: (height * 0.5) + 50, width: 300, height: 50)
        
        
        button.addTarget(self, action:#selector(self.sendMessage(_:)), for: .touchUpInside)
        button.backgroundColor = .orange
        button.setTitle("Gönder", for: .normal)
        
        self.view.addSubview(eMail)
        self.view.addSubview(message)
        self.view.addSubview(button)
        self.view.addSubview(oncelik)
        self.view.addSubview(_title)
        self.view.addSubview(outputLabel)
    }
        
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }
    
    func splitFunc(_ mail: String) -> Array<String> {
        let email = eMail.text ?? ""
        let resultList = email.components(separatedBy: ",")
        return resultList
    }
    
    @objc func sendMessage(_ sender: AnyObject?) {
        let email = eMail.text ?? ""
        let message = message.text ?? ""
        outputLabel.text = "";
        
        if (email == "" || message == ""){
            outputLabel.text = "Email veya mesaj boş olamaz!"
            return
            
        }
        let emails = splitFunc(email)
        for mail in emails {
            if (!isValidEmail(mail) ){
                outputLabel.text = "Email Doğru değil!"
                return
            } else{
                outputLabel.text? += "To: \(mail) \n"
            }
        }
        if (oncelik.isOn){
            outputLabel.textColor = .red
        }else{
            outputLabel.textColor = .black
        }
        outputLabel.text? += "Mesaj: \(message)"
    }
}

//mail1@gmail.com,mail2@gmail.com,mail3@gmail.com
