import Foundation
import ArgumentParser

struct FileTemplateSync: ParsableCommand {

    @Argument(help: "The path to the XcodeFileTemplates folder.")
    var xcodeFileTemplatesFolderPath: String

    @Flag(name: .shortAndLong, help: "Shows additional logs.")
    var verbose: Bool

    let templatesFolder: String = "~/Library/Developer/Xcode/Templates/File\\ Templates"

    func listDirectories() throws -> [String] {
        let output = try shell("ls -d -1 \(xcodeFileTemplatesFolderPath)/*/")
        return output.components(separatedBy: "\n").filter { $0 != "" }
    }

    func run() throws {
        let directories = try listDirectories()
        guard directories.isEmpty == false else {
            print("Found no template directories under \(xcodeFileTemplatesFolderPath).")
            return
        }
        if verbose == true {
            print("Found Directories: \(directories)")
        }
        for d in directories {
            let path = String(d[xcodeFileTemplatesFolderPath.endIndex...])
            print("Processing \(path)")
            let pathToOperate = templatesFolder + path
            let eraseCommand = "rm -rf \(pathToOperate)"
            if verbose == true {
                print("Erasing \(pathToOperate)")
                print(eraseCommand)
            }
            _ = try shell(eraseCommand)
            let copyCommand = "cp -r \(d) \(pathToOperate)"
            if verbose == true {
                print("Copying \(path)")
                print(copyCommand)
            }
            _ = try shell(copyCommand)
        }
        print("Done.")
    }
}

enum Error: Swift.Error {
    case failedToGetShellOutput
}

func shell(_ command: String) throws -> String {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", command]

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    task.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()

    guard let output = String(data: data, encoding: .utf8) else {
        throw Error.failedToGetShellOutput
    }

    return output
}

FileTemplateSync.main()
