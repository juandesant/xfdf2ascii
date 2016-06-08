This repository provides tools in Python (using LXML.Etree) and XQuery for retrieving comments from Adobe XFDF format files into different ASCII-based exports: CSV, TST, others.

`xfdf2xhtml.xquery`
===================

This file has been tested with the [`xquilla` command line tool](http://xqilla.sourceforge.net/HomePage)

You can test it, for instace, with:

    xqilla -i examples/Technical_Document_Comments.xfdf xfdf2xhtml.xquery

That command should generate the following output (after formatting it with `xmllint --format`):

    <?xml version="1.0"?>
    <xhtml xmlns="http://www.w3.org/1999/xhtml">
      <body>
        <table>
          <tr>
            <th align="left">Issue #</th>
            <th align="left">Section</th>
            <th align="left">Page</th>
            <th align="left">Author</th>
            <th align="left">Observation</th>
          </tr>
          <tr>
            <td>1</td>
            <td>Document Software Box</td>
            <td>3</td>
            <td>Santander-Vela, Juande</td>
            <td>The version of the DocBook plugin, and of the related XSLT files for templating/personalisation for TM should be included, in this and the rest of Cameo-generated documents.</td>
          </tr>
          <tr>
            <td>2</td>
            <td>List of Tables</td>
            <td>10</td>
            <td>Santander-Vela, Juande</td>
            <td>Regarding the issue of tables vs diagrams, there should be a clarification. It would be less confusing if the "diagram" included a table in graphical form, but because it is really in table form, the SysML link is lost.</td>
          </tr>
          <tr>
            <td>3</td>
            <td>TM_REQ_358, TBD118</td>
            <td>133</td>
            <td>Santander-Vela, Juande</td>
            <td>Could this be brought into a TBC soon?</td>
          </tr>
          <tr>
            <td>4</td>
            <td>TM_REQ_358, TBD119</td>
            <td>133</td>
            <td>Santander-Vela, Juande</td>
            <td>Could this be a TBC soon?</td>
          </tr>
          <tr>
            <td>5</td>
            <td>TM_VREQ_29</td>
            <td>230</td>
            <td>Santander-Vela, Juande</td>
            <td>Seems to verify TM_REQ_35, but that requirement has been removed from the T0000-0000-RS-001 document.</td>
          </tr>
        </table>
      </body>
    </xhtml>
