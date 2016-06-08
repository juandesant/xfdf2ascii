declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xfdf="http://ns.adobe.com/xfdf/";

<xhtml><body><table>
<tr><th align="left">issue</th><th align="left">author</th><th align="left">page</th><th align="left">comment</th></tr>
{
for $h at $issue in //xfdf:highlight
let $page := $h/@page
let $author := $h/@title
let $comment := $h/xfdf:contents/text()
return <tr><td>{fn:string($issue)}</td><td>{fn:string($author)}</td><td>{fn:string($page)}</td><td>{fn:string($comment)}</td></tr>
}
</table></body></xhtml>
