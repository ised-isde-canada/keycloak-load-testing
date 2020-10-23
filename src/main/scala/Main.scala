import java.nio.file
import java.io.File
import java.util
import java.awt.Desktop
import java.util.Arrays
import scala.sys.process._
import scala.concurrent.duration._

object Main extends App{

    
    println("Running normal load test against - LOCAL")

    def runLoadTestLOCAL() = {
        "sbt gatling:testOnly scheduledTest.KCScheduledTest".!
    }

    // println("Running normal load test against - DEV")

    // def runLoadTestDEV () = {
    //     "sbt gatling:testOnly scheduledTest.KCScheduledDev".!
    // }

    // println("Running normal load test against - DEMO")
    
    // def runLoadTestDEMO () = {
    //     "sbt gatling:testOnly scheduledTest.KCScheduledDemo".!
    // }
}
