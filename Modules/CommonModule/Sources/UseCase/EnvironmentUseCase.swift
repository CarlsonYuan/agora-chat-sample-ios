import Foundation
import AgoraChat

public class EnvironmentUseCase {
    
    public enum AppKey {
        case sample
        case custom(String)
        
        var rawValue: String {
            switch self {
            case .sample:
                return "61717166#1069763"
            case .custom(let value):
                return value
            }
        }
    }
    public static func initializeAgoraChatSDK(appKey: AppKey) {
        let options = AgoraChatOptions(appkey: appKey.rawValue)
        options.enableConsoleLog = true
        AgoraChatClient.shared().initializeSDK(with: options)
    }
    
}
