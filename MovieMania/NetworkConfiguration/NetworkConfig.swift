

import AFNetworking

class NetworkConfig: NSObject {
    
    //get Movies function
    static func getMovieDetails( route : String, query : String?,page: Int?, completion:@escaping (_ data : AnyObject?, _ error : Error?) -> Void)
    {
       
        var parameters : [String: String] = [:]
        
        //parameters  will change a/c to passed parameters
        if let searchedQuery = query {
            
            parameters = ["api_key":"\(Routes.apiKey)","query":"\(searchedQuery)","page":"\(page!)"]
        }
        else {
            
            parameters = ["api_key":"\(Routes.apiKey)","page":"\(page!)"]
        }

        //network configuration
        let manager = AFHTTPSessionManager(baseURL: URL(string: Routes.baseUrl))
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/html", "application/x-www-form-urlencoded") as? Set<String>
        
        //get request
        manager.get(route, parameters: parameters, progress: nil, success: { (task, data) in
           
            //return completion with data
            completion(data as AnyObject?, nil)

        }) { (task, error) in
            //return completion with error
            completion(nil,error)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}
