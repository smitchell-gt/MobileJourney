import Quick
import Nimble
@testable import IOSStarter

class YourSpec: QuickSpec {
    override func spec() {
        describe("Your Spec") {
            context("when the condition is met") {
                it("does this thing") {
                    let yourThing = YourThing()
                    expect(yourThing.theThing()).to(beTrue())
                }
            }
        }
    }
}
