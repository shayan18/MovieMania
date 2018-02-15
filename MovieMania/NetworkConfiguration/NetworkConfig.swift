

import AFNetworking



class NetworkConfig: NSObject {
    
    
    static func getMoviedetails( route : String, query : String?,page: Int?, completion:@escaping (_ data : AnyObject?, _ error : Error?) -> Void)
    {
        var searchRoute = String()
        

        if query == nil || page == nil {
            
            searchRoute = ("\(route)?\(Routes.apiKey)")

        }
        else {
            
            searchRoute = ("\(route)?\(Routes.apiKey)&query=\(query!)&page=\(page!)")
                    }

        

        
        let manager = AFHTTPSessionManager(baseURL: URL(string: Routes.baseUrl))
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        
        
    
        manager.get(searchRoute, parameters: nil, progress: nil, success: { (task, data) in
           
            completion(data as AnyObject?, nil)

        }) { (task, error) in
            
            completion(nil,error)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}
