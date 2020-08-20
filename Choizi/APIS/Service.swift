//
//  Service.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit.UIImage
import FirebaseStorage

let ref = Storage.storage()

struct Service {
    
    static func uploadImage(image: UIImage, completion: @escaping(Result<String, Error>)->Void) {
        
        guard let imgData = image.jpegData(compressionQuality: 0.7) else { return }
        let filePath = NSUUID().uuidString
        let reference = ref.reference(withPath: "/images/\(filePath)")
        
        reference.putData(imgData, metadata: nil) { data, err in
            if err != nil {
                completion(.failure(err!))
            } else {
                
                reference.downloadURL { url, err in
                    if err != nil {
                        completion(.failure(err!))
                    } else {
                        guard let imgURL = url?.absoluteString else { return }
                        completion(.success(imgURL))
                    }
                }
                
            }
        }
    }
    
}
