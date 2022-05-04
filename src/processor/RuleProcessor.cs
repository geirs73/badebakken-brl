using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Text;

namespace Processor;

public class RuleProcessor
{
    private static Regex multiWhitespaceRegex = new Regex(@"\s+", RegexOptions.Compiled);
    private int foo = 5;

    public XDocument ProcessRuleDocument(XDocument doc)
    {
        foo = 3;
        Console.Out.Write(foo);
        var ns = doc?.Root?.Name.Namespace ?? throw new ArgumentException("bad bad doc");
        var punktumCollection = from d in doc.Root.Descendants(ns + "p")
                    select d;
        foreach (var p in punktumCollection)
        {
            // var elementReader = p.CreateReader(ReaderOptions.OmitDuplicateNamespaces);
            // elementReader.MoveToContent();
            // var innerXml = elementReader.ReadInnerXml();
            var innerText = p.Value;
            // var innerText2 = p.ToString();
            var normalizedInnerText = multiWhitespaceRegex.Replace(innerText, " ");
            #pragma warning disable CA5350
            using var crypto = SHA1.Create(); 
            #pragma warning restore CA5350
            var textBytes = Encoding.UTF8.GetBytes(normalizedInnerText);
            var hashBytes = crypto.ComputeHash(textBytes);
            // var hashHexString = Convert.ToHexString(hashBytes).ToLowerInvariant();
            // p.SetAttributeValue("hash", hashHexString);
            var hashBase64String = Convert.ToBase64String(hashBytes);
            p.SetAttributeValue("hash", hashBase64String);

            var randomBytes = RandomNumberGenerator.GetBytes(4);
            var newId = Convert.ToHexString(randomBytes).ToLowerInvariant();
            p.SetAttributeValue("new-id", newId);
        }
                
        return doc;
    }
}


