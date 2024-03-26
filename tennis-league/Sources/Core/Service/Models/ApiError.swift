// MARK: - CustomError
enum ApiError: Error {
    case bodyNotFound
    case queryError(_ : Error?)
    case decodeError(_: Error)
    case authError(_: Error?)
    case NoContentDecodeError
}

enum AuthError: Error {
    case getCachedUserEmail
    case sendSignInLink(_: Error?)
    case noContentCastModel
    case authError(_: Error?)
}
