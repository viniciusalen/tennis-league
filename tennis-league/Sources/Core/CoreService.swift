import FirebaseFirestore

protocol CoreServicing {
    func execute<T: Decodable>(
        query: Query,
        then completion: @escaping (Result<[T], ApiError>) -> Void
    )
    func execute<T: Decodable>(
        documentReference: DocumentReference,
        then completion: @escaping (Result<T, ApiError>) -> Void
    )
}

final class CoreService: CoreServicing {
    // MARK: Documents
    /// Get possibles documents decoded on specific model based on query
    func execute<T: Decodable>(
        query: Query,
        then completion: @escaping (Result<[T], ApiError>) -> Void
    ) {
        perform(query: query) { (result: Result<[T], ApiError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    // MARK: - Only Document
    /// Get document decoded on specific model based on query
    func execute<T: Decodable>(
        documentReference: DocumentReference,
        then completion: @escaping (Result<T, ApiError>) -> Void
    ) {
        perform(documentReference: documentReference) { (result: Result<T, ApiError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

private extension CoreService {
    // MARK: - Perform method for Documents
    func perform<T: Decodable>(
        query: Query,
        then completion: @escaping (Result<[T], ApiError>) -> Void
    ) {
        query.getDocuments { [weak self] query, error in
            guard error == nil,
                  let queryResult = query
            else {
                self?.logFailsQueryLogError()
                return completion(.failure(.queryError(error)))
            }
            
            guard !queryResult.isEmpty,
                  let documentsResult = query?.documents
            else {
                self?.logSuccessQueryWithoutDocument()
                return completion(.failure(.bodyNotFound))
            }
            
            var objects: [T] = []
            for document in documentsResult {
                do {
                    let object = try Firestore.Decoder().decode(T.self, from: document.data())
                    objects.append(object)
                } catch let error {
                    self?.logSuccessQueryButHasDecodeError()
                    return completion(.failure(.decodeError(error)))
                }
            }
            self?.logSuccessResponse()
            completion(.success(objects))
        }
    }
    
    // MARK: - Perform method for just one Document
    func perform<T: Decodable>(
        documentReference: DocumentReference,
        then completion: @escaping (Result<T, ApiError>) -> Void
    ) {
        documentReference.getDocument { [weak self] query, error in
            guard error == nil,
                  let queryResult = query
            else {
                self?.logFailsQueryLogError()
                return completion(.failure(.queryError(error)))
            }
            
            guard queryResult.exists,
                  let data = queryResult.data()
            else {
                self?.logSuccessQueryWithoutDocument()
                return completion(.failure(.bodyNotFound))
            }
            do {
                let object = try Firestore.Decoder().decode(T.self, from: data)
                self?.logSuccessResponse()
                return completion(.success(object))
            } catch let error {
                self?.logSuccessQueryButHasDecodeError()
                return completion (.failure(.decodeError(error)))
            }
        }
    }
    
    // MARK: - HELPERS
    func logFailsQueryLogError() {
        print("----- FAILS QUERY ----")
        print("ERROR: Query has not return any result")
    }
    
    func logSuccessQueryWithoutDocument() {
        print("----- SUCCESS QUERY ----")
        print("NOTE: There is no document in this query")
    }
    
    func logSuccessQueryButHasDecodeError() {
        print("----- SUCCESS QUERY ----")
        print("NOTE: Error decoding model")
    }
    
    func logSuccessResponse() {
        print("----- SUCCESS RESPONSE ----")
    }
}
