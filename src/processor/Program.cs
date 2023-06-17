// See https://aka.ms/new-console-template for more information

using System.Xml;
using System.Xml.Linq;

namespace Processor;

internal static class Program
{
    private static void Main(string[] args)
    {
        Console.WriteLine("Hello, World! " + string.Join(", ", args));

        var rp = new RuleProcessor();

        XmlReaderSettings xmlReaderSettings = new()
        {
            DtdProcessing = DtdProcessing.Ignore,
            IgnoreWhitespace = false
        };

        XmlWriterSettings xmlWriterSettings = new()
        {

        };


        using XmlReader reader = XmlReader.Create(@"../static/vedtekter.xml", xmlReaderSettings);
        XDocument xDoc = XDocument.Load(reader);
        XDocument xDoc2 = rp.ProcessRuleDocument(xDoc);

        if (!Directory.Exists("output"))
            Directory.CreateDirectory("output");

        using XmlWriter writer = XmlWriter.Create("output/vedtekter-eksempel-proc.xml", xmlWriterSettings);
        xDoc2.Save(writer);
    }
}