#!/usr/bin/env python
from lxml import etree
import sys

comments_file = open("examples/Technical_Document_Comments.xfdf", "r")
comments_xml = etree.parse(comments_file)
root = comments_xml.getroot()
prefix = None
try:
    prefix = root.tag.partition("}")[0].partition("{")[-1]
except:
    pass

if prefix:
    highlights = root[0].findall("{%s}highlight" % prefix)
else:
    highlights = root[0].findall("highlight")

with sys.stdout as out:
    line = u"\tIssue\tSection\tPage\tBy\tObservation Description\n".encode("utf-8")
    out.write(line)
    issue = 1
    for h in highlights:
        try:
            page = int(h.get("page"))+1
        except:
            continue
        try:
            author = h.get("title")
        except:
            continue
        try:
            content = h.find("{%s}contents" % prefix).text
        except:
            continue
        content = content.replace("\n","-").replace("\r","")
        line = u"NA\t{2}\tSECTION\t{0}\t{3}\t{1}\n".format(page,content,issue,author).encode("utf-8")
        out.write(line)
        issue += 1
