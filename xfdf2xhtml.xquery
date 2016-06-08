declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xfdf="http://ns.adobe.com/xfdf/";

<xhtml><body><table>
<tr><th align="left">Issue #</th><th align="left">Section</th><th align="left">Page</th><th align="left">Author</th><th align="left">Observation</th></tr>
{
for $h at $issue in //xfdf:highlight
let $page := $h/@page
let $author := $h/@title
let $comment := $h/xfdf:contents/text()
let $rich_comment := $h/xfdf:contents-richtext/body/p/span/text()
let $comment := fn:concat($comment,$rich_comment)
return <tr><td>{fn:string($issue)}</td><td>SECTION</td><td>{fn:string($page)}</td><td>{fn:string($author)}</td><td>{fn:string($comment)}</td></tr>
}
</table></body></xhtml>
