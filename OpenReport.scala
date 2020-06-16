import java.nio.file
import java.io.File
import java.util
import java.awt.Desktop
import java.util.Arrays

object OpenReport{
    def getListOfFiles(dir: String):List[File] = {
        val d = new File(dir)
        if (d.exists && d.isDirectory) {
            d.listFiles.filter(_.isFile).toList
        } else {
            List[File]()
        }
    }

    def getListOfFolders(dir: String):List[File] = {
        val d = new File(dir)
        if (d.exists && d.isDirectory) {
            d.listFiles.filter(_.isDirectory).toList
        } else {
            List[File]()
        }
    }

    def main(args: Array[String]){
        // get current directory
        val currentDirectory = new java.io.File("./target/gatling/").getCanonicalPath()

        // get folders for reports.. need to figure out how to get most recent one
        val folders = getListOfFolders(currentDirectory)
        

        //get most recent folder from list
        val recent = folders.sorted.last.getCanonicalPath()
        // System.out.println("Folders :" + folders.sorted.last)
       
        // get list of files from recent folder
        val files = getListOfFiles(recent)
        // System.out.println("Files : " + files)

        //html file of most recent report
        val html = files(0)

        // open report in computer's default browser
        Desktop.getDesktop().browse(html.toURI())
    }
}

// /Users/sagal/Desktop/Other/ISED github/keycloak-load-testing/keycloakloginsimulator - 250 users