declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xfdf="http://ns.adobe.com/xfdf/";

declare namespace functx = "http://www.functx.com";
declare function functx:trim
  ( $arg as xs:string? )  as xs:string {

   replace(replace($arg,'\s+$',''),'^\s+','')
 };

<xhtml><body><table>
<tr><th align="left">Issue #</th><th align="left">Section</th><th align="left">Page</th><th align="left">Author</th><th align="left">Observation</th></tr>
{
  for $h at $issue in //xfdf:highlight
  let $page := fn:string($h/@page + 1) (: XFDF page numbers are 0-based :)
  let $author := fn:string($h/@title)
  let $comment := $h/xfdf:contents/text()
  let $rich_comment := $h/xfdf:contents-richtext/body/p/span/text()
  let $comment := fn:concat($comment,$rich_comment)
  let $tokenized_comment := fn:tokenize($comment, ":")
  let $comment := $tokenized_comment[1]
  let $section := fn:string($h/@subject) (: if it exists, it might include context :)
  let $section := fn:concat($section,fn:string($tokenized_comment[0]))
  return <tr><td>{fn:string($issue)}</td><td>{$section}</td><td>{$page}</td><td>{$author}</td><td>{$tokenized_comment}</td></tr>
}
</table></body></xhtml>
