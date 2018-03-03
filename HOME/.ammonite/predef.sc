println(s"Hello ${sys.env.get("MY_NAME").orElse(sys.env.get("USER")).getOrElse("User")}!")

def encodeToUnicode(x: String): String = x.map(c => "\\u%04x".format(c.toInt)).mkString

implicit class ToUnicode(val x: String) extends AnyVal {
  def encodeToUnicode: String = x.map(c => "\\u%04x".format(c.toInt)).mkString
}

def printHelp(name: String, help: => Unit): Unit = {
  println(
    s"""========================
       |To use $name, do
       |""".stripMargin
  )
  help
}

def printLoadInfo(name: String, version: String, methodName: String): Unit =
  println(
    s"""=============================
       |Loading $name - $version
       |-----------------------------
       |NOTE:
       |To specify the version, run
       |  $methodName("YOUR_VERSION")
       |
       |e.g.)
       |$methodName("$version")
       |""".stripMargin
  )

object DefaultVersions {
  /* updated: 2018-03-03 */
  val Scalaz = "7.2.20"
  val BetterFile = "3.4.0"
  val FastParse = "1.0.0"
  val PlayJson = "2.6.9"
}

def printDefaultVersions: Unit = {
  import scala.reflect.runtime.{universe => ru}
  val mirror = ru.runtimeMirror(getClass.getClassLoader)

  val moduleSymbol = ru.typeOf[DefaultVersions.type].termSymbol.asModule
  val moduleMirror = mirror.reflectModule(moduleSymbol)
  val instanceMirror = mirror.reflect(moduleMirror.instance)

  val fields = moduleSymbol.typeSignature.declarations.filter(_.asTerm.isVal)
  val stringBuilder = new StringBuilder
  stringBuilder ++= s"""======================
                       | Default Versions
                       |----------------------
                       |""".stripMargin
  val max = fields.map(_.name.toString.trim.length).max
  for (f <- fields) {
    val fieldMirror = instanceMirror.reflectField(f.asTerm)
    val fieldName = f.name.toString.trim
    stringBuilder ++= s"${" " * (max - fieldName.length)}${fieldName}: ${fieldMirror.get}\n"
  }
  println(stringBuilder ++= "======================")
}


def scalazLib(version: String) = "org.scalaz" %% "scalaz-core" % version
def betterFileLib(version: String) = "com.github.pathikrit" %% "better-files" % version
def fastParseLib(version: String) = "com.lihaoyi" %% "fastparse" % version
def playJsonLib(version: String) = "com.typesafe.play" %% "play-json" % version

import coursier.ivy

def addIvyRepo(url: String): Unit = interp.repositories() ++= Seq(ivy.IvyRepository.fromPattern(
  url +: ivy.Pattern.default
))


import coursier.MavenRepository
import coursier.core.Authentication

def addMavenRepo(url: String, auth: Option[Authentication]): Unit = interp.repositories() ++= Seq(MavenRepository(
  url,
  authentication = auth
))


def loadDependency(coordinate: coursier.Dependency): Unit = interp.load.ivy(coordinate)

def loadDependencies(coordinates: coursier.Dependency*): Unit = interp.load.ivy(coordinates:_*)

def loadPlayJson(version: String = DefaultVersions.PlayJson): Unit = {
  printLoadInfo("Play-Json", version, "loadPlayJson")
  interp.load.ivy(playJsonLib(version))
  printHelp("Play-Json", helpPlayJson)
}
def loadPlayJson: Unit = loadPlayJson(DefaultVersions.PlayJson)

def helpPlayJson: Unit = println(
  """---
    |import play.api.libs.json._
    |---
    |""".stripMargin
)

def loadScalaz(version: String = DefaultVersions.Scalaz): Unit = {
  printLoadInfo("Scalaz", version, "loadScalaz")
  interp.load.ivy(scalazLib(version))
  printHelp("Scalaz", helpScalaz)
}
def loadScalaz: Unit = loadScalaz(DefaultVersions.Scalaz)

def helpScalaz: Unit = println(
  """---
    |import scalaz._
    |import Scalaz._
    |---
    |""".stripMargin
)

def loadBetterFile(version: String = DefaultVersions.BetterFile): Unit = {
  printLoadInfo("BetterFile", version, "loadBetterFile")
  interp.load.ivy(betterFileLib(version))
  printHelp("better-files", helpBetterFile)
}
def loadBetterFile: Unit = loadBetterFile(DefaultVersions.BetterFile)

def helpBetterFile: Unit = println(
  """---
    |import better.files._
    |import java.io.{File => JFile}
    |
    |import better.files.Dsl._
    |---
    |""".stripMargin
)

def loadFastParse(version: String = DefaultVersions.FastParse): Unit = {
  printLoadInfo("FastParse", version, "loadFastParse")
  interp.load.ivy(fastParseLib(version))
  printHelp("fastparse", helpFastParse)
}
def loadFastParse: Unit = loadFastParse(DefaultVersions.FastParse)

def helpFastParse: Unit = println(
  """---
    |import fastparse.all._
    |---
    |""".stripMargin
)
