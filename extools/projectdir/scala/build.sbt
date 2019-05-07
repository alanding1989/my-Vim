name := "simpleapp"

version := "1.0"

scalaVersion := "2.12.8"
ensimeScalaVersion in ThisBuild := "2.12.8"

libraryDependencies ++= Seq(
		"org.apache.spark" % "spark-core_2.12" % "2.4.2",
		"org.apache.spark" % "spark-sql_2.12" % "2.4.2",
)

