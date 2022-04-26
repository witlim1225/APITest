//
//  ViewController.swift
//  APITest
//
//  Created by TWLim on 2022/04/26.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var responseView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func callCurrentTime(_ sender: Any) {
        do {
            // URL 설정 및 GET 방식으로 API 호출
//            let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime")
            
//            let response = try String(contentsOf: url!)
            let url = "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime"
            AF.request(url, method: .get).responseString { response in
                print("\(response)")
            }
            
            // 읽어온 값을 레이블에 표시
//            self.currentTime.text = response
//            self.currentTime.sizeToFit()
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    @IBAction func post(_ sender: Any) {
        let userId = (self.userId.text)!
        let name = name.text!
//        let param = "userId=\(userId)&name=\(name)"
//        let paramData = param.data(using: .utf8)
        
        // URL 객체 정의
//        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echo")
        let url = "http://swiftapi.rubypaper.co.kr:2029/practice/echo"
        let param: Parameters = [
            "userId" : "abc",
            "name" : "def"
        ]
        
        let alamo = AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
        
        alamo.responseJSON { response in
            print("JSON=\(try! response.result.get())")
            if let jsonObject = try! response.result.get() as? [String: Any] {
                print("userId = \(jsonObject["userId"]!)")
                print("name = \(jsonObject["name"]!)")
            }
        }
        
        // URLRequest 객체를 정의 하고, 요청 내용을 담는다.
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.httpBody = paramData
        
        // HTTP 메세지 헤더 설정
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.addValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        // URLSession 객체를 통해 전송 및 응답갑 로직 처리
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // 서버가 응답이 없거나 통신이 실패했을 때
//            if let e = error {
//                NSLog("An error has occured : \(e.localizedDescription)")
//                return
//            }
//
//            // 응답 처리 로직
//            // 메인 스레드에서 비동기로 처리되도록 한다.
//            DispatchQueue.main.async() {
//                do {
//                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
//
//                    guard let jsonObject = object else { return }
//
//                    // JSON 결과값을 추출한다.
//                    let result = jsonObject["result"] as? String
//                    let timeStamp = jsonObject["timestamp"] as? String
//                    let userId = jsonObject["userId"] as? String
//                    let name = jsonObject["name"] as? String
//
//                    // 결과가 성공일 때만 텍스트 뷰에 출력한다.
//                    if result == "SUCCESS" {
//                        self.responseView.text =
//                            "아이디 : \(userId!)  \n"
//                            + "이름 : \(name!) \n"
//                            + "응답결과 : \(result) \n"
//                            + "요청방식 : x-www-form-urlencoded"
//                    }
//                } catch let e as NSError {
//                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
//                }
//            }
//
//        }
//        // POST 전송
//        task.resume()
    }
    
    @IBAction func json(_ sender: Any) {
        let userId = (self.userId.text)!
        let name = name.text!
        let param = ["userId" : userId, "name" : name ]
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        // URL 객체 정의
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echoJSON")
        
        // URLRequest 객체를 정의 하고, 요청 내용을 담는다.
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        // HTTP 메세지 헤더 설정
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URLSession 객체를 통해 전송 및 응답갑 로직 처리
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // 서버가 응답이 없거나 통신이 실패했을 때
            if let e = error {
                NSLog("An error has occured : \(e.localizedDescription)")
                return
            }
   
            // 응답 처리 로직
            // 메인 스레드에서 비동기로 처리되도록 한다.
            DispatchQueue.main.async() {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary

                    guard let jsonObject = object else { return }
                    
                    // JSON 결과값을 추출한다.
                    let result = jsonObject["result"] as? String
                    let timeStamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    // 결과가 성공일 때만 텍스트 뷰에 출력한다.
                    if result == "SUCCESS" {
                        self.responseView.text =
                            "아이디 : \(userId!)  \n"
                            + "이름 : \(name!) \n"
                            + "응답결과 : \(result) \n"
                            + "요청방식 : JSON"
                    }
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        
        }
        // POST 전송
        task.resume()
    }
}

