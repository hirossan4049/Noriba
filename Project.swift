import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains Noriba App target and Noriba unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
//let project = Project.app(name: "Noriba",
//                          platform: .iOS,
//                          additionalTargets: ["NoribaKit", "NoribaUI"])

let project = Project(name: "Noriba",
                      targets:
                        makeAppTargets(name: "Noriba",
                                       platform: .iOS,
                                       dependencies: ["NoribaKit", "NoribaUI"].map { TargetDependency.target(name: $0) })
                      + makeFrameworkTargets(name: "NoribaKit", platform: .iOS)
                      + makeFrameworkTargets(name: "NoribaUI", platform: .iOS, dependencies: [TargetDependency.target(name: "NoribaKit")])
)

private func makeFrameworkTargets(name: String, platform: Platform, dependencies: [TargetDependency] = []) -> [Target] {
    let sources = Target(name: name,
                         platform: platform,
                         product: .framework,
                         bundleId: "com.h1rose.\(name)",
                         infoPlist: .default,
                         sources: ["Targets/\(name)/Sources/**"],
                         resources: ["Targets/\(name)/Resources/**"],
                         dependencies: dependencies)
    let tests = Target(name: "\(name)Tests",
                       platform: platform,
                       product: .unitTests,
                       bundleId: "com.h1rose.\(name)Tests",
                       infoPlist: .default,
                       sources: ["Targets/\(name)/Tests/**"],
                       resources: [],
                       dependencies: [.target(name: name)] + dependencies)
    return [sources, tests]
}

private func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
    let platform: Platform = platform
    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "0.0.3",
        "CFBundleVersion": "1",
        "CFBundleDisplayName": "のりば検索",
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "ITSAppUsesNonExemptEncryption": "false"
    ]
    
    let mainTarget = Target(
        name: name,
        platform: platform,
        product: .app,
        bundleId: "com.h1rose.\(name)",
        infoPlist: .extendingDefault(with: infoPlist),
        sources: ["Targets/\(name)/Sources/**"],
        resources: ["Targets/\(name)/Resources/**"],
        dependencies: dependencies
    )
    
    let testTarget = Target(
        name: "\(name)Tests",
        platform: platform,
        product: .unitTests,
        bundleId: "com.h1rose.\(name)Tests",
        infoPlist: .default,
        sources: ["Targets/\(name)/Tests/**"],
        dependencies: [
            .target(name: "\(name)")
        ])
    return [mainTarget, testTarget]
}
