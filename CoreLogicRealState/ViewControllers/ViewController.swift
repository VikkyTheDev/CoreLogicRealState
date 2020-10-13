//
//  ViewController.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 09/09/20.
//  Copyright © 2020 Mobilecoderz. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLogic
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String{
            CoreLogicServices.shared.setAuth(token: CLAuthenticationModel(accessToken: accessToken, tokenType: "", expiresIn: 12, scope: "", iss: "", envAccessRestrict: true, geoCodes: [""], roles: [""], sourceExclusion: [""]))
            switchToNextScreen()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func switchToNextScreen(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CoreLogicApiList")
        navigationController?.pushViewController(vc!, animated: true)
    }
    func authenticate(){
        CoreLogicServices.shared.authenticate().done({ (data: CLAuthenticationModel) in
            UserDefaults.standard.set(data.accessToken, forKey: "accessToken")
            CoreLogicServices.shared.setAuth(token: data)
            self.switchToNextScreen()
            //self.matchAddress()
            print("json \(data)")
        }).catch({ (error) in
            print("Error: \(error)")
        }).finally {
            
        }
    }

    
    @IBAction func authButtonTapped(sender: Any){
        authenticate()
    }
   
}
//"propertySummary": {
//    "address": {
//      "singleLineAddress": "356 Old Windsor Road Seven Hills NSW 2147"
//    },
//    "attributes": {
//      "isCalculatedLandArea": true,
//      "landArea": 30624
//    },
//    "coordinate": {
//      "latitude": -33.77975716,
//      "longitude": 150.96343728
//    },
//    "id": 14208222,
//    "locationIdentifiers": {
//      "councilAreaId": 762,
//      "localityId": 9299,
//      "postCodeId": 101331,
//      "streetId": 277392
//    },
//    "propertyPhoto": {
//      "largePhotoUrl": "https://das-web.corelogic.asia/v1/asset/2NLSZFF6TQI6NLNBSNM6JJA22U/resize;m=exact;w=768;h=512",
//      "mediumPhotoUrl": "https://das-web.corelogic.asia/v1/asset/2NLSZFF6TQI6NLNBSNM6JJA22U/resize;m=exact;w=470;h=313",
//      "scanDate": "2009-07-11",
//      "thumbnailPhotoUrl": "https://das-web.corelogic.asia/v1/asset/2NLSZFF6TQI6NLNBSNM6JJA22U/resize;m=exact;w=120;h=80"
//    },
//    "propertyStatus": {
//      "otmForRent": false,
//      "otmForSale": false,
//      "recentSale": false
//    },
//    "propertySubType": "Commercial",
//    "propertyType": "COMMERCIAL",
//    "radiusSummary": {
//      "distanceFromPoint": "10.55"
//    }
//  }
//}

