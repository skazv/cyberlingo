//
//  Network.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 19.02.25.
//

//import Foundation
//import UIKit
//
//
//class NetworkManager {
//    struct CourseData: Codable {
//        let courses: [Course]
//    }
//
//    struct Course: Codable {
//        let id: Int
//        let name: String
//        let imageName: String
//        let imagePath: String?
//        let isBlocked: Bool
//        let isExamPassed: Bool
//        let color: String
//        let description: String
//        let lessons: [Lesson]
//    }
//
//    struct Lesson: Codable {
//        let id: Int
//        let lessonType: String
//        let name: String
//        let imageName: String
//        let view1image: String
//        let view1name: String
//        let view1description: String
//        let isBlocked: Bool
//        let isExamPassed: Bool
//        let color: String
//        let description: String
//        let words: [Word]
//    }
//
//    struct Word: Codable {
//        let id: Int
//        let name: String
//        let translate: String
//        let transcription: String
//        let image: String
//        let type: String
//        let category: String
//        let remember: Int
//        let module: String
//        let description: String
//        let sound: String
//        let isFlipped: Bool
//    }
//
//    static let jsonString = """
//    {
//        "courses": [
//            {
//                "id": 0,
//                "name": "LocalisationManager.basicCourse",
//                "imageName": "EdLvl1",
//                "imagePath": "img/basic/basic.jpg",
//                "isBlocked": false,
//                "isExamPassed": false,
//                "color": "ColorLib.realLowLil.rawValue",
//                "description": "LocalisationManager.basicCourseDescription",
//                "lessons": [
//                    {
//                        "id": 0,
//                        "lessonType": "encryption",
//                        "name": "LocalisationManager.cryptographyCourse",
//                        "imageName": "caesar",
//                        "view1image": "caesar",
//                        "view1name": "Caesar cipher",
//                        "view1description": "The Caesar cipher is a simple encryption method...",
//                        "isBlocked": false,
//                        "isExamPassed": false,
//                        "color": "ColorLib.realLowLil.rawValue",
//                        "description": "LocalisationManager.cryptographyCourseDescription",
//                        "words": [
//                            {
//                                "id": 0,
//                                "name": "abc",
//                                "translate": "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
//                                "transcription": "abcdefghijklmnopqrstuvwxyz",
//                                "image": "👋",
//                                "type": "",
//                                "category": "",
//                                "remember": 0,
//                                "module": "",
//                                "description": "",
//                                "sound": "hello",
//                                "isFlipped": false
//                            }
//                        ]
//                    }
//                ]
//            }
//        ]
//    }
//    """
//
//    static func parseJSON(jsonString: String) {
//        guard let jsonData = jsonString.data(using: .utf8) else {
//            print("Ошибка конвертации строки в Data")
//            return
//        }
//
//        do {
//            let decodedData = try JSONDecoder().decode(CourseData.self, from: jsonData)
//            print(decodedData)  // Выводим весь объект
//        } catch {
//            print("Ошибка декодирования JSON:", error)
//        }
//    }
//    
//    static func fetchCourses(completion: @escaping ([Course]?) -> Void) {
//        
//        guard let url = URL(string: "http://127.0.0.1:8000/courses") else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching data: \(error)")
//                completion(nil)
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                completion(nil)
//                return
//            }
//            
//            do {
//                print(data)
//                let decodedData = try JSONDecoder().decode([Course].self, from: data)
//                DispatchQueue.main.async {
//                    completion(decodedData)
//                }
//            } catch {
//                print("Decoding error: \(error)")
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//    
//}
