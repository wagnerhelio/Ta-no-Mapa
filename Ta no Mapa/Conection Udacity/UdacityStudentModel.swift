//
//  UdacityStudentModel.swift
//  Ta no Mapa
//
//  Created by Wagner  Filho on 27/09/2018.
//  Copyright © 2018 Artesmix. All rights reserved.
//

import Foundation
class UdacityStudentModel {
    var Students = [UdacityStudentInformation]()
    
    func LoadStudents (completionHandler: @escaping (_ error: String?) -> Void) {
        GetStudents { (results, error) in
            if (error != nil) {
                completionHandler(error)
            } else {
                self.Students.removeAll()
                for row in results! {
                    let student = UdacityStudentInformation(data:row)
                    self.Students.append(student)
                }
                completionHandler(nil)
            }
        }
    }
}
