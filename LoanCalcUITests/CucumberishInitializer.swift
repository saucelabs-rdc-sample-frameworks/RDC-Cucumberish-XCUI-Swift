import Foundation
import Cucumberish

public class CucumberishInitializer: NSObject {
    @objc public class func CucumberishSwiftInit()
    {
        //Using XCUIApplication only available in XCUI test targets not the normal Unit test targets.
        
        //A closure that will be executed only before executing any of your features
        beforeStart { () -> Void in
            XCUIApplication().launch()
            XCUIApplication().activate()
        }
        //A Given step definition
        Given("the app is running") { (args, userInfo) -> Void in
            guard XCUIApplication().state == .runningForeground else {
                return XCTFail("App is not running in foreground")
            }
            print(XCUIApplication().debugDescription)
        }
        
        When("^I clear fields$") { (args, userInfo) -> Void in
            self.clearOutFields()
        }
        When("^I force memory warning$") { (args, userInfo) -> Void in
            UIApplication.shared.perform(Selector(("_performMemoryWarning")))
        }
        When("^I enter \"([^\\\"]*)\" in \"([^\\\"]*)\"$") { (args, userInfo) -> Void in
            let application = XCUIApplication()
            guard let arg = args?[1] else {
                return XCTFail("Textfield name missing")
            }
            let resultView = application.textFields[arg]
            self.waitForElementToAppear(resultView)
            resultView.tap()
            guard let textToEnter = args?[0] else {
               return XCTFail("Text to enter missing")
            }
            let text = textToEnter
            resultView.typeText(text)
        }
        
        When("^I tap the \"([^\\\"]*)\" key$") { (args, userInfo) -> Void in
            let application = XCUIApplication()
            guard let arg = args?[0] else {
                return XCTFail("Key name missing")
            }
            application.keys[arg].tap()
        }
        
        When("^I clear the \"([^\\\"]*)\" field$") { (args, userInfo) -> Void in
            let application = XCUIApplication()
            guard let arg = args?[0] else {
                return XCTFail("Textfield name missing")
            }
            let resultView = application.textFields[arg]
            self.waitForElementToAppear(resultView)
            resultView.tap()
            resultView.doubleTap()
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: resultView.label.count + 1)
            resultView.typeText(deleteString)
        }
        
        Then("^I should see \"([^\\\"]*)\" in the \"([^\\\"]*)\" label$") { (args, userInfo) -> Void in
            let application = XCUIApplication()
            guard let arg = args?[1] else {
                return XCTFail("Label name missing")
            }
            let resultView = application.staticTexts[arg]
            self.waitForElementToAppear(resultView)
            guard let compare = args?[0], let compareDouble = Double(compare) else {
                return XCTFail("Compare argument missing")
            }
            
            let formatter = NumberFormatter()
            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .currency
            formatter.locale = Locale.current
            
            let formattedNumber = formatter.string(from: compareDouble as NSNumber)
            let value = resultView.label
            XCTAssertEqual(value, formattedNumber)
        }
        
        Then("^I take a screenshot called \"([^\\\"]*)\"$") { (args, userInfo) -> Void in
            guard let screenshotName = args?[0] else {
                return XCTFail("Screenshot name missing")
            }
            let app = XCUIApplication()
            let screenshot = app.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.name = screenshotName
            attachment.lifetime = .keepAlways
            guard let testCase = userInfo?[kXCTestCaseKey] as? XCTestCase else {
                return XCTFail("Unable to retrieve test case from userInfo")
            }
            testCase.add(attachment)
        }
        
        Then("^I should see \"([^\\\"]*)\" in the \"([^\\\"]*)\" field$") { (args, userInfo) -> Void in
            let application = XCUIApplication()
            guard let arg = args?[1] else {
                return XCTFail("Textfield name missing")
            }
            let resultView = application.textFields[arg]
            self.waitForElementToAppear(resultView)
            guard let compare = args?[0] else {
                return XCTFail("Compare argument missing")
            }
            let value = resultView.label
            XCTAssertEqual(value, compare)
        }
        
        
        //Another step definition
        And("all data cleared") { (args, userInfo) -> Void in
            //Assume you defined an "I tap on \"(.*)\" button" step previousely, you can call it from your code as well.
            let testCase = userInfo?[kXCTestCaseKey] as? XCTestCase
            SStep(testCase, "I tap the \"Clear All Data\" button")
        }
        //Create a bundle for the folder that contains your "Features" folder. In this example, the CucumberishInitializer.swift file is in the same directory as the "Features" folder.
        let bundle = Bundle(for: CucumberishInitializer.self)

        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: nil, excludeTags: nil)
    }
    
    
    class func clearOutFields(){
        let application = XCUIApplication()
        let fields = application.textFields
        
        for i in 0..<fields.count {
            let field = fields[fields.element(boundBy: i).label]
            if field.exists {
                field.doubleTap()
                let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: field.label.count + 1)
                field.typeText(deleteString)
            }
        }
    }
    
    class func waitForElementToAppear(_ element: XCUIElement){
        let result = element.waitForExistence(timeout: 5)
        guard result else {
            XCTFail("Element does not appear")
            return
        }
    }
}

