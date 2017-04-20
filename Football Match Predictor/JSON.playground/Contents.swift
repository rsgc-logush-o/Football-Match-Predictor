//: Playground - noun: a place where people can play

import Cocoa

func getJSON()
{
    let adress : String = "insert string"
    
    if let url = URL(string: adress)
    {
        print(url)
        
        let urlRequest = URLRequest(url : url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration : config)
        
        let task = session.dataTask(with: urlRequest)
        {
            (data, response, error)in
            
        }
        
        
        
    }
    
    
}