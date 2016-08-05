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
  let $contents := $h/xfdf:contents/text()
  let $rich_contents := $h/xfdf:contents-richtext/body/p/span/text()
  let $content := fn:concat($contents,$rich_contents)
  let $tokenized_comment := fn:tokenize($content, ":")
  let $comment := functx:trim($tokenized_comment[2])
  let $section := fn:string($h/@subject) (: if it exists, it might include context :)
  let $section := fn:concat($section, fn:string(functx:trim($tokenized_comment[1])))
  let $section_priority_item_info := fn:tokenize($tokenized_comment[1], "\|")
  let $section_part := fn:string(functx:trim($section_priority_item_info[1]))
  let $priority_part := fn:string(functx:trim($section_priority_item_info[2]))
  let $item_part := fn:string(functx:trim($section_priority_item_info[3]))
  return <tr><td>{fn:string($issue)}</td><td>{$section_part}, {$item_part}</td><td>{$page}</td><td>{$author}</td><td>{$priority_part}</td><td>{$comment}</td></tr>
}
</table></body></xhtml>
