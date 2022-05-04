
// See https://aka.ms/new-console-template for more information

using System.Xml;
using System.Xml.Linq;
using Processor;

Console.WriteLine("Hello, World! " + string.Join(", ", args));

var rp = new RuleProcessor();

XmlReaderSettings xmlReaderSettings = new XmlReaderSettings();
xmlReaderSettings.DtdProcessing = DtdProcessing.Ignore;
xmlReaderSettings.IgnoreWhitespace = false;

XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();

using var reader = XmlReader.Create(".\\sample\\vedtekter-eksempel.xml", xmlReaderSettings);
var xDoc = XDocument.Load(reader);
var xDoc2 = rp.ProcessRuleDocument(xDoc);

if (!Directory.Exists("output")) 
    Directory.CreateDirectory("output");

using var writer = XmlWriter.Create("output/vedtekter-eksempel-proc.xml", xmlWriterSettings);
xDoc2.Save(writer);


