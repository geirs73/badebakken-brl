using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Text;

namespace Processor;

public class RuleProcessor
{
    private static readonly Regex MultiWhitespaceRegex
        = new(@"\s+", RegexOptions.Compiled);

    private int _foo = 5;

    public XDocument ProcessRuleDocument(XDocument doc)
    {
        _foo = 3;
        Console.Out.Write(_foo);
        XNamespace ns = doc?.Root?.Name.Namespace ?? throw new ArgumentException("bad bad doc");
        IEnumerable<XElement> punktumCollection = from d in doc.Root.Descendants(ns + "p")
                                select d;
        foreach (XElement p in punktumCollection)
        {
            // var elementReader = p.CreateReader(ReaderOptions.OmitDuplicateNamespaces);
            // elementReader.MoveToContent();
            // var innerXml = elementReader.ReadInnerXml();
            string innerText = p.Value;
            // var innerText2 = p.ToString();
            string normalizedInnerText = MultiWhitespaceRegex.Replace(innerText, " ");
            byte[] textBytes = Encoding.UTF8.GetBytes(normalizedInnerText);
#pragma warning disable CA5350
            byte[] hashBytes = SHA1.HashData(textBytes);
#pragma warning restore CA5350
            // var hashHexString = Convert.ToHexString(hashBytes).ToLowerInvariant();
            // p.SetAttributeValue("hash", hashHexString);
            string hashBase64String = Convert.ToBase64String(hashBytes);
            p.SetAttributeValue("hash", hashBase64String);

            byte[] randomBytes = RandomNumberGenerator.GetBytes(4);
            string newId = Convert.ToHexString(randomBytes).ToLowerInvariant();
            p.SetAttributeValue("new-id", newId);
        }

        return doc;
    }
}
