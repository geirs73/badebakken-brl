using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Text;

namespace Processor;

public class RuleProcessor
{
    private static Regex multiWhitespaceRegex = new Regex(@"\s+", RegexOptions.Compiled);

    public XDocument ProcessRuleDocument(XDocument doc)
    {
        var ns = doc?.Root?.Name.Namespace ?? throw new Exception("bad bad doc");
        var punktumCollection = from d in doc.Root.Descendants(ns + "paragraf")
                    select d;
        foreach (var p in punktumCollection)
        {
            // var elementReader = p.CreateReader(ReaderOptions.OmitDuplicateNamespaces);
            // elementReader.MoveToContent();
            // var innerXml = elementReader.ReadInnerXml();
            var innerText = p.Value;
            // var innerText2 = p.ToString();
            var normalizedInnerText = multiWhitespaceRegex.Replace(innerText, " ");
            var crypto = MD5.Create();
            var textBytes = Encoding.UTF8.GetBytes(normalizedInnerText);
            var hashBytes = crypto.ComputeHash(textBytes);
            var hashHexString = Convert.ToHexString(hashBytes).ToLowerInvariant();
            p.SetAttributeValue("hash", hashHexString);
        }
                
        return doc;
    }
}


