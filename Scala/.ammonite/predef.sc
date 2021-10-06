println(s"Hello ${sys.env.get("MY_NAME").orElse(sys.env.get("USER")).getOrElse("User")}!")

def encodeToUnicode(x: String): String = x.map(c => "\\u%04x".format(c.toInt)).mkString

implicit final class ToUnicode(private val x: String) extends AnyVal {
  def encodeToUnicode: String = x.map(c => "\\u%04x".format(c.toInt)).mkString
}

implicit class IntLiteral(private val sc: StringContext) extends AnyVal {
  def i(args: Any*): Int = Integer.parseInt(sc.parts.mkString.replaceAllLiterally("_", ""), 10)
}

implicit class LongLiteral(private val sc: StringContext) extends AnyVal {
  def l(args: Any*): Long = sc.parts.mkString.replaceAllLiterally("_", "").toLong
}

implicit class BigIntLiteral(private val sc: StringContext) extends AnyVal {
  def bi(args: Any*): BigInt = BigInt(sc.parts.mkString.replaceAllLiterally("_", ""))
}

implicit class BinaryToIntOrLong(private val sc: StringContext) extends AnyVal {
  def b(args: Any*): Int = Integer.parseInt(sc.parts.mkString.replaceAllLiterally("_", ""), 2)
  def B(args: Any*): Long = java.lang.Long.parseLong(sc.parts.mkString.replaceAllLiterally("_", ""), 2)
}

def toHexBinaryString(data: Seq[Byte]): String = {
  val hexCode = "0123456789ABCDEF"
  data.foldLeft(List.empty[Char]) { (acc, b) =>
    hexCode(b & 15) :: hexCode(b >> 4 & 15) :: acc
  }.reverse.mkString
}

def epochSecondToSydneyDateTime(epochSecond: Long): java.time.ZonedDateTime =
  java.time.Instant.ofEpochSecond(epochSecond).atZone(java.time.ZoneId.of("Australia/Sydney"))

import scala.reflect._
import scala.reflect.runtime.universe._
def printVals[A: TypeTag](valueProcess: Any => String): Unit = {
  import scala.reflect.runtime.{universe => ru}
  val mirror = ru.runtimeMirror(getClass.getClassLoader)

  val theType = ru.typeOf[A]
  val moduleSymbol = theType.termSymbol.asModule
  val moduleMirror = mirror.reflectModule(moduleSymbol)
  val instanceMirror = mirror.reflect(moduleMirror.instance)

  val fields = moduleSymbol.typeSignature.declarations.filter(_.asTerm.isVal)
  val max = fields.map(_.name.toString.trim.length).max
  val fieldNamesAndValues = for {
    f <- fields
    fieldMirror = instanceMirror.reflectField(f.asTerm)
    fieldName = f.name.toString.trim
  } yield s"${" " * (max - fieldName.length)}${fieldName}: ${valueProcess(fieldMirror.get)}"

  val typeName = {
    val typeNameSplit = theType.toString.split("\\.")
    val lastTwo = typeNameSplit.drop(typeNameSplit.length - 2)
    if (lastTwo.last == "type") lastTwo.head else lastTwo.last
  }

  val maxLength = fieldNamesAndValues
    .map(_.length)
    .foldLeft(0)((max, length) => if (length > max) length else max)
  val length = Some(s" $typeName".length).filter(_ > maxLength).getOrElse(maxLength)

  println(
    fieldNamesAndValues.mkString(
      s"""${"=" * length}
         | $typeName
         |${"-" * length}
         |""".stripMargin,
      "\n",
      s"\n${"=" * length}"
    )
  )
}
