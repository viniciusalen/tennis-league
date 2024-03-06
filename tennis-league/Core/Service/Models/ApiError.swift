// MARK: - CustomError
enum ApiError: Error {
    case bodyNotFound
    case queryError(_ : Error?)
    case decodeError(_: Error)
}
