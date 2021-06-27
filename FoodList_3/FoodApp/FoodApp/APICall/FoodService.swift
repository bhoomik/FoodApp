//
//  FoodService.swift
//
//
//

import Foundation
import Alamofire


typealias JSONDictionary = [String:Any]



class Connectivity
{
    class func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}

class FoodService {
    typealias SuccessHandler = (AFDataResponse<Any>) -> Void
    typealias FailureHandler = (Error) -> Void
    
    // MARK: - Helper Methods
    class func getWebServiceCall(_ strURL : String, params : [String : Any]? = nil, headerPrm : [String : String]? = nil, isShowLoader : Bool, success : @escaping SuccessHandler, failure : @escaping FailureHandler) {
        
        if Connectivity.isConnectedToInternet() {
            //if isShowLoader {  CommonFunction.Instance.displayProgressBar()  }
            
            print("REQUEST: ",strURL)
            print("\nParameters: ",params ?? "")
            
            AF.request(strURL, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (resObj) -> Void in
                switch((resObj).result) {
                case .success(let value):
                    print("RESPONSE: ",resObj)
                    if isShowLoader {
                        //CommonFunction.Instance.hideProgressBar()
                        
                    }
                    success(resObj)
                case .failure(let error):
                    print("ERROR: ",error.localizedDescription)
                    // if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                    //  CommonFunction.Instance.showMesaageBar(message: ConstMessages.kDefaultErrorMessage)
                    //self.showAlertWithCompletion(pTitle: "", pStrMessage: Messages.kInValidPhoneNumber, completionBlock: nil)
                    failure(error)
                //let resJson = JSON(resObj.result.value!)
                }
            }
        }else{
            //Here Display Alert for No Internect
            // CommonFunction.Instance.showMesaageBar(message: ConstMessages.kDefaultNoInternetMessage)
        }
    }
    
    
    
}






















