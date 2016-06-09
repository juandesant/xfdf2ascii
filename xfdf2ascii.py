#!/usr/bin/env python
from lxml import etree
import sys

comments_file = open("examples/Technical_Document_Comments.xfdf", "r")
comments_xml = etree.parse(comments_file)
root = comments_xml.getroot()

def get_root_prefix(xml_root):
    prefix = None
    try:
        prefix = xml_root.tag.partition("}")[0].partition("{")[-1]
    except:
        pass
    return prefix

prefix = get_root_prefix(root)

def get_all_tags(xml_element, tag, prefix=None):
    tags = None
    if prefix:
        tags = xml_element.findall("{{0}}{1}".format(prefix,tag))
    else:
        tags = xml_element.findall(tag)
    return tags
    
def get_tag(xml_element, tag, prefix=None):
    tag_result = None
    if prefix:
        tag_result = xml_element.find("{{0}}{1}".format(prefix,tag))
    else:
        tag_result = xml_element.find(tag)
    return tag_result
    
    

with sys.stdout as out:
    line = u"\tIssue\tSection\tPage\tBy\tObservation Description\n".encode("utf-8")
    out.write(line)
    issue = 1
    highlights = get_all_tags(root[0], "highlight", prefix=prefix)
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
            content = get_tag(h, "contents", prefix=prefix).text
        except:
            continue
        try:
            rich_content = get_tag(h, "contents-richtext", prefix=prefix)
            rich_content_text = get_all_tags(rich_content,"span",prefix="http://www.w3.org/1999/xhtml").text
        except:
            continue
        content = content + rich_content_text
        content = content.replace("\n","-").replace("\r","")
        line = u"NA\t{2}\tSECTION\t{0}\t{3}\t{1}\n".format(page,content,issue,author).encode("utf-8")
        out.write(line)
        issue += 1
