//
//  API.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/07/18.
//

import Foundation
public class RequestObservable {
    private lazy var jsonDecoder = JSONDecoder()

    func call<T: Codable>(req: APIRequest) -> Observable<T> {
        let request = req.request(with: req)
        return URLSession.shared.rx.data(request: request)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .map {
            try JSONDecoder().decode(T.self, from: $0)
        }
            .observe(on: MainScheduler.asyncInstance)
    }

//    public init() {
//        urlSession = URLSession(configuration:
//            URLSessionConfiguration.default)
//    }

//    //MARK: function for URLSession takes
//    public func callAPI<T: Decodable>(request: URLRequest)
//        -> Observable<T> {
//        //MARK: creating observable
//        return Observable.create { [weak self] observer in
//            //MARK: create URLSession dataTask
//            let task = self?.urlSession.dataTask(with: request) { (data,
//                                                                   response, error) in
//                if let httpResponse = response as? HTTPURLResponse {
//                    let statusCode = httpResponse.statusCode
//                    do {
//                        let _data = data ?? Data()
//                        if (200...399).contains(statusCode) {
//                            let objs = try self?.jsonDecoder.decode(T.self, from:
//                                _data)
//                            //MARK: observer onNext event
//                            observer.onNext(objs!)
//                        }
//                        else {
//                            observer.onError(error!)
//                        }
//                    } catch {
//                        //MARK: observer onNext event
//                        observer.onError(error)
//                    }
//                }
//                //MARK: observer onCompleted event
//                observer.onCompleted()
//            }
//            task?.resume()
//            //MARK: return disposable
//            return Disposables.create {
//                task?.cancel()
//            }
//        }
//    }

}
