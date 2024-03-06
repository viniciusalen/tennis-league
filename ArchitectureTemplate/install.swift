import Foundation

enum Templates {
    static let names = [
        "VIPScene.xctemplate",
    ]
    static let relativePath = "Developer/Xcode/Templates/Project Templates/iOS/Application"
}

enum Messages {
    static let promptInstall = "🪄 Would you like to install/replace VIP-C and other Xcode templates? (YES or NO)"
    static let errorMessage = "❌ Oops! Something went wrong 😡"
    static let installAborted = "Template installation aborted! 👋"
    static let exitMessage = "Bye Bye 👋"
    static let separator: String = "===================================="
    static func install(at path: String) -> String { "Templates will be copied to: \(path)" }
    static func successMessage(_ file: String) -> String { "✅ Template \(file) was installed successfully 🎉" }
}

enum CommandLineValues: String {
    case yes = "YES"
    case no = "NO"

    static func from(_ input: String) -> CommandLineValues? {
        switch input.lowercased().folding(options: .diacriticInsensitive, locale: nil) {
        case "y", "yes", "s", "sim":
            return .yes
        case "n", "no", "nao":
            return .no
        default:
            return nil
        }
    }
}

func output(_ message: String, useSeparator: Bool = true) {
    if useSeparator { print(Messages.separator) }
    print(message)
}

func installTemplates() throws {
    let fileManager = FileManager.default
    let destinationPath = try fileManager.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent(Templates.relativePath)
        .path

    output(Messages.install(at: destinationPath))

    try fileManager.createDirectory(atPath: destinationPath, withIntermediateDirectories: true, attributes: nil)

    for file in Templates.names {
        try? fileManager.removeItem(atPath: "\(destinationPath)/\(file)")

        try fileManager.copyItem(atPath: file, toPath: "\(destinationPath)/\(file)")

        output(Messages.successMessage(file), useSeparator: false)
    }
}

func main() throws {
    signal(SIGINT) { _ in
        print()
        output(Messages.installAborted)
        exit(0)
    }

    var input: CommandLineValues?

    repeat {
        guard let userInput = readLine(strippingNewline: true) else { continue }
        input = CommandLineValues.from(userInput)
    } while input == nil

    if input == .yes {
        try installTemplates()
    }
}

do {
    output(Messages.promptInstall)
    try main()
    output(Messages.exitMessage)
} catch {
    output("\(Messages.errorMessage): \(error.localizedDescription)", useSeparator: false)
}
