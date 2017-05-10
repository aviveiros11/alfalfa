//
// Copyright (c) 2015, Project-Haystack
// Licensed under the Academic Free License version 3.0
//
// History:
//   22 Feb 11  Brian Frank  Creation
//

using fandoc
using web
using sidewalk
using sidewalkForum

**
** HtmlRender is base class for pre-rendering the content
** as static HTML stored in memory in the Lib data structure
**
internal class HtmlRenderer
{
  HaystackLoader loader() { loaderRef ?: throw Err("Loader not configured") }
  internal HaystackLoader? loaderRef

  WebOutStream out() { outRef ?: throw Err("Not in render()'") }
  internal WebOutStream? outRef

  virtual Str render()
  {
    buf := StrBuf()
    this.outRef = WebOutStream(buf.out)
    onContent
    this.outRef = null
    return buf.toStr
  }

  virtual Void onContent() { throw UnsupportedErr() }

  Void prevNext(XItem item)
  {
    prev := item.prev;
    next := item.next
    out.div("class='prev-next'")

    out.span
    if (prev != null)
      out.w("&#x25c4;").a(item.prev.uri).w("$prev.name").aEnd
    out.w("&nbsp;").spanEnd

    out.span
    if (next != null)
      out.a(next.uri).w("$next.name").aEnd.w("&#x25ba;")
    out.spanEnd

    out.divEnd
  }
}

**************************************************************************
** Index (Home Page)
**************************************************************************

internal class IndexRenderer : HtmlRenderer
{
  override Void onContent()
  {
    out.div
     .a(`https://haystackconnect.org/`, "style='border-bottom: none;'")
     .img(`/pod/haystackws/res/img/banner.png`)
     .aEnd
     .divEnd

    out.div("id='index-sections'")

    out.div("id='index-section-1'")
      .h1.w("What is Haystack?").h1End

      .p.w("Project Haystack is an open source initiative to streamline working with
            data from the Internet of Things. We standardize semantic data models and web
            services with the goal of making it easier to unlock value from the vast quantity
            of data being generated by the smart devices that permeate our homes, buildings,
            factories, and cities. Applications include automation, control, energy, HVAC,
            lighting, and other environmental systems.").pEnd

      .h2.w("Learn More").h2End
      .ul
        .li.a(`/doc/Intro`).w("Start with the Documentation").aEnd.liEnd
        .li.a(`/tag`).w("View the Tag Docs").aEnd.liEnd
      .ulEnd
      .h2.w("Get Involved").h2End
       .p.w("We use the <a href='/forum/topic'>forum</a> to gather feedback and
             collaborate.  If you would like to participate, please
             <a href='/user/signup'>signup</a> and let us know how
             you would like to pitch-in!").pEnd
    .divEnd

    out.div("id='index-section-2'")
      .h2.w("Why Do We Need Haystack?").h2End
      .p.w("Macro trends in technology are making it increasingly cost effective to
            instrument and collect data about the operations and energy usage
            of buildings.  We are now awash in data and the new problem is how to
            make sense of it.  Today most operational data has poor semantic
            modeling and requires a manual, labor intensive process to \"map\" the
            data before value creation can begin.  Pragmatic use of naming
            conventions and taxonomies can make it more cost effective to
            analyze, visualize, and derive value from our operational data.").pEnd
    .divEnd

    out.div("id='index-section-3'")
      .h2.w("Who Should Participate?").h2End
      .p.w("Project Haystack encompasses the entire value chain of building systems
            and related intelligent devices. Owners and consultants can specify that
            Haystack conventions are used in their building automation systems to ensure
            cost effective analytics and management of their buildings for years to come.
            System integrators and manufacturers who integrate Haystack support into
            their projects and products are positioned for the future of value added
            services.").pEnd
    .divEnd

    out.div("id='index-section-4'")
      .h2.w("Open Source").h2End
      .p.w("The Haystack community and all associated intellectual property is managed
            as an open source project using the <a href='/doc/License'>Academic
            Free License 3.0</a>.  Anyone is free to participate as long as contributed
            IP is licensed under the AFL.  This ensures that Haystack IP is open
            and freely available for any commercial use.").pEnd
    .divEnd

    out.divEnd
  }
}

**************************************************************************
** AboutRenderer (About Page)
**************************************************************************

internal class AboutRenderer : HtmlRenderer
{
  override Void onContent()
  {
    out.div
    out.h1.w("About Project Haystack").h1End

    out.p.w("Project Haystack is a 501C tax-exempt non-stock corporation formed May 28, 2014
             under the provisions of Chapter 10 of Title 13.1 of the Code of Virginia of 1950.
             The corporation functions as a trade association with the purpose of fostering the
             common association and interests of software and technology companies focused on
             developing semantic modeling solutions for data related to smart devices including:
             building equipment systems, automation and control devices, sensors and sensing devices,
             promotion and education with respect to the semantic data modeling industry for building
             automation systems, and to engage in educational activities directed towards the
             improvement of business conditions of the semantic data modeling industry for smart
             device data, all on a not-for-profit basis, as provided in Section 501(c)(6) of the
             Internal Revenue Code of 1986, as amended (the “Code”).").pEnd

    out.p.w("All work developed by the project-haystack.org community is provided for use as
             open source software under the ").a(`/doc/License`).w("Academic Free License 3.0").aEnd.w(".").pEnd

    out.h1.w("Board of Directors").h1End

    out.p.w("The management and operations of the Corporation are governed by a Board of Directors
             of the Corporation. Board members are appointed by the following companies that participated
             and funded the formation of the Corporation:").pEnd

    out.p.ul
      .li.a(`http://www.airmaster.com.au/`).w("Airmaster (Australia)").aEnd.liEnd
      .li.a(`http://enerliance.com/`).w("Enerliance/Yardi").aEnd.liEnd
      .li.a(`http://www.lynxspring.com/`).w("Lynxspring").aEnd.liEnd
      .li.a(`http://www.j2inn.com/`).w("J2 Innovations").aEnd.liEnd
      .li.a(`http://skyfoundry.com/`).w("SkyFoundry").aEnd.liEnd
      .li.a(`http://www.wattstopper.com/`).w("Wattstopper").aEnd.liEnd
      .li.a(`http://www.usa.siemens.com/buildingtechnologies`).w("Siemens").aEnd.liEnd
     .ulEnd

    out.h1.w("Associate Members").h1End

    out.p.w("In addition, the Bylaws provide for an Associate Membership level.
             The following companies are Associate members:").pEnd

    out.p.ul
      .li.a(`http://www.alturaassociates.com/`).w("Altura").aEnd.liEnd
      .li.a(`http://www.arup.com/`).w("Arup").aEnd.liEnd
      .li.a(`http://bassg.com/`).w("BASSG").aEnd.liEnd
      .li.a(`http://www.buenosystems.com.au/`).w("BUENO Systems").aEnd.liEnd
      .li.a(`http://buildingsystemsolutions.net/bss/`).w("Building Systems Solutions").aEnd.liEnd
      .li.a(`http://www.caba.org/`).w("CABA").aEnd.liEnd
      .li.a(`http://www.connexxenergy.com/`).w("Connexx Energy").aEnd.liEnd
      .li.a(`http://www.controlco.com/`).w("Controlco").aEnd.liEnd
      .li.a(`http://gegroup.com.au/`).w("Grosvenor Engineering Group (Australia)").aEnd.liEnd
      .li.a(`http://intellastar.com/`).w("Intellastar").aEnd.liEnd
      .li.a(`http://www.intelligentbuildings.com/`).w("Intelligent Buildings").aEnd.liEnd
      .li.a(`http://iotwarez.com/`).w("IoT Warez").aEnd.liEnd
      .li.a(`http://www.kmccontrols.com/`).w("KMC Controls").aEnd.liEnd
      .li.a(`http://knx.org/knx-en/index.php`).w("KNX Association").aEnd.liEnd
      .li.a(`https://www.sensorfact.com/`).w("sensorFact").aEnd.liEnd
     .ulEnd

    out.p.w("You can contact Project Haystack Corporation for additional information on becoming
             a member by emailing ").a(`mailto:projecthaystackinfo@gmail.com`)
         .w("projecthaystackinfo@gmail.com").aEnd.w(".").pEnd

    out.divEnd
  }
}

**************************************************************************
** Doc Index
**************************************************************************

internal class DocIndexRenderer : HtmlRenderer
{
  new make(HaystackLoader loader) { this.loaderRef = loader }
  override Void onContent()
  {
    out.div("id='index-toc'")
    out.ol
    loader.docIndex.each |item|
    {
      if (item is Str)
      {
        out.h2.w(item).h2End
        return
      }

      doc := loader.docsMap[((Obj[])item).first.toStr]
      out.li.a(doc.uri).w(doc.name).aEnd
      out.p.w(doc.summary).pEnd
      sub := doc.fandoc.findHeadings.findAll |h| { h.level==2 }
      if (sub.size > 0)
      {
        out.p
        sub.each |h, i|
        {
          if (i > 0) out.w(", ")
          text := h.children.first.toStr.trim
          frag := h.anchorId
          out.a(doc.uri + `#$h.anchorId`).w(text).aEnd
        }
        out.p
      }
      out.liEnd
    }
    out.olEnd
    out.divEnd
  }
}

**************************************************************************
** Doc Details Render
**************************************************************************

internal class DocRenderer : HtmlRenderer
{
  new make(HaystackLoader loader, XDoc doc) { this.loaderRef = loader; this.doc = doc }
  XDoc doc
  override Void onContent()
  {
    title   := doc.fandoc.meta["title"]
    chapter := loader.docs.findIndex |d| { d.fandoc.meta["title"] == title }
    docSideBar
    out.div("id='doc-content'")
    prevNext(doc)
    chapter.times { out.h1("class='skip'").h1End }
    out.h1.w(title).h1End
    out.w(loader.writeFandoc(doc, doc.fandoc))
    prevNext(doc)
    out.divEnd
  }

  private Void docSideBar()
  {
    out.div("id='doc-sidebar'")
    out.p.a(`/doc`).w("TOC").aEnd.pEnd
    out.ol
    loader.docs.each |d|
    {
      cur := d.name == doc.name
      cls := cur ? "class='cur'" : ""
      out.li(cls).a(d.uri).w(d.name).aEnd
      if (cur) docSubToc
      out.liEnd
    }
    out.olEnd
    out.divEnd
  }

  private Void docSubToc()
  {
    roots := HeadingNode[,]
    flat  := HeadingNode[,]
    heads := doc.fandoc.findHeadings
    heads.each |h|
    {
      newNode := HeadingNode { heading=h }
      flat.insert(0, newNode)
      if (h.level==2) roots.add(newNode)
      else
      {
        p := flat.find |n| { n.heading.level < h.level }
        p.kids.add(newNode)
      }
    }

    out.ol
    roots.each |n| { writeHeading(n) }
    out.olEnd
  }

  private Void writeHeading(HeadingNode node)
  {
    out.li
    h := node.heading
    text := h.children.first.toStr.trim
    if (h.anchorId == null) loader.err("$doc.name: heading missing anchor: $text")
    else out.a(`#${h.anchorId}`).w(text).aEnd
    if (!node.kids.isEmpty)
    {
      out.ol
      node.kids.each |kid| { writeHeading(kid) }
      out.olEnd
    }
    out.liEnd
  }
}

internal class HeadingNode
{
  Heading? heading
  HeadingNode[] kids := [,]
}

**************************************************************************
** Tag Index
**************************************************************************

internal class TagIndexRenderer : HtmlRenderer
{
  new make(HaystackLoader loader) { this.loaderRef = loader }
  override Void onContent()
  {
    out.table("id='index-table'")
    loader.tags.each |tag|
    {
      out.tr
      out.td.a(tag.uri).w(tag.name).aEnd.tdEnd
      out.td.w(tag.summaryHtml).tdEnd
      out.trEnd
    }
    out.tableEnd
  }
}

**************************************************************************
** Tag Details Render
**************************************************************************

internal class TagDetailsRenderer : HtmlRenderer
{
  new make(HaystackLoader loader, XTag tag) { this.loaderRef = loader; this.tag = tag }
  XTag tag
  override Void onContent()
  {
    tagSideBar
    out.div("id='doc-content' class='tag-detail'")
    prevNext(tag)

    // title
    out.h1("class='tag'").w(tag.name).h1End

    // generate standard HTML summary for tag
    out.table("id='tag-details'")
    out.tr.th.w("Kind:").thEnd.td.w(tag.kind).tdEnd.trEnd
    tagHyperlinks("Also See:", tag.alsoSee)
    tagHyperlinks("Used With:", tag.usedWith)
    out.tableEnd

    // append detailed fandoc, and save html
    out.w(loader.writeFandoc(tag, tag.fandoc))

    // we have a docInclude reference, append that too
    include := tag.dict["docInclude"] as Str
    if (include != null) docInclude(include)

    prevNext(tag)
    out.divEnd
  }

  private Void tagSideBar()
  {
    out.div("id='doc-sidebar'")
    out.ul
    loader.tags.each |t|
    {
      out.li.a(t.uri).w(t.name).aEnd.liEnd
    }
    out.ulEnd
    out.divEnd
  }

  private Void tagHyperlinks(Str dis, XTag[] links)
  {
    if (links.isEmpty) return
    out.tr.th.w(dis).thEnd.td
    links.each |link, i|
    {
      if (i > 0) out.w(", ")
      out.a(link.uri).w(link.name).aEnd
    }
    out.tdEnd.trEnd
  }

  private Void docInclude(Str uri)
  {
    // uri must be "name" or "name#frag"
    name  := uri
    Str? frag  := null
    pound := uri.index("#")
    if (pound != null) { name = uri[0..<pound]; frag = uri[pound+1..-1] }

    // lookup doc
    doc := loader.docsMap[name] ?: throw Err("docInclude bad name: $uri")

    // if there is no fragment we include the whole thing
    if (pound == null)
    {
      out.h1("id='doc-title'").a(doc.uri).w("From: $doc.name").aEnd.h1End
      out.w(loader.writeFandoc(doc, doc.fandoc))
      return
    }

    // lookup section (everything until level ends)
    heading := ""
    included := Doc()
    Heading? inside := null
    fandoc := loader.parseFandoc(doc.name, doc.fandocStr.in)
    nodes := fandoc.children
    fandoc.removeAll
    nodes.each |node, i|
    {
      h := node as Heading
      if (h != null)
      {
        if (h.anchorId == frag) { inside = h; heading = h.children.first.toStr; return }
        else if (inside != null && h.level <= inside.level) inside = null
      }
      if (inside != null) included.add(node)
    }
    if (included.children.isEmpty) throw Err("docInclude bad anchor: $uri")

    // append fandoc
    out.h1("id='doc-title'").a(doc.uri + `#$frag`).w("From: $doc.name | $heading").aEnd.h1End
    out.w(loader.writeFandoc(doc, included))
  }
}

**************************************************************************
** Downloads
**************************************************************************

internal class DownloadsRenderer : HtmlRenderer
{
  new make() {}
  override Void onContent()
  {
    out.h2("id='resources'").w("Resources").h2End
    out.ul
      .li.a(`http://youtu.be/5C6GwLbYqTw`).w("Introduction Video").aEnd
         .w(": video presentation of what Haystack is all about").liEnd
      .li.a(`http://www.youtube.com/watch?v=dStqInuDkiE&feature=youtu.be&utm_source=FIN+Community+Subscribers&utm_campaign=7624d694e1-FIN+News+-+November+2013&utm_medium=email&utm_term=0_3a20e47258-7624d694e1-314608765`).w("NHaystack Setup Video").aEnd
         .w(": step-by-step video for setting up nhaystack module in Niagara").liEnd
      .li.a(`https://www.caba.org/CABA/DocumentLibrary/Public/Project-Haystack.aspx`).w("CABA White Paper").aEnd
         .w(": a white paper produced in cooperation with the Continental Automated Building Association").liEnd
    .ulEnd

    out.h2("id='source'").w("Source Code").h2End
    out.p.w("The following open source projects provide implementations:").pEnd
    out.ul
      .li.a(`https://bitbucket.org/project-haystack`).w("Haystack Website").aEnd
         .w(": source for this website, docs, and tag definitions").liEnd
      .li.a(`https://bitbucket.org/brianfrank/haystack-java`).w("Haystack Java Toolkit").aEnd
         .w(": light weight J2ME compliant client and server implementation").liEnd
      .li.a(`https://bitbucket.org/jasondbriggs/nhaystack`).w("NHaystack").aEnd
         .w(": Niagara module to add Haystack tagging and REST API").liEnd
      .li.a(`https://bitbucket.org/jasondbriggs/haystack-cpp/wiki/Home`).w("Haystack CPP").aEnd
         .w(": C++ Haystack client and server implementation").liEnd
      .li.a(`https://pub.dartlang.org/packages/haystack`).w("Haystack Dart").aEnd
         .w(": client library for Dart programming language").liEnd
      .li.a(`https://bitbucket.org/lynxspring/nodehaystack`).w("NodeHaystack").aEnd
         .w(": node.js client/server implemtnation").liEnd
    .ulEnd

    out.h2("id='tags'").w("Tags").h2End
    out.p.w("The following downloads of the tag database are available:").pEnd
    out.ul
      .li.a(`/download/tags.txt`).w("Tag Names Text").aEnd.w(": flat text file of tag names").liEnd
      .li.a(`/download/tags.csv`).w("Tags CSV").aEnd.w(": comma separated tag name, kind").liEnd
    .ulEnd

    out.h2("id='tz'").w("TimeZones").h2End
    out.p.w("The following downloads of the <a href='/doc/TimeZones'>timezone</a> database are available:").pEnd
    out.ul
      .li.a(`/download/tz.txt`).w("TimeZone Names Text").aEnd.w(": flat text file of timezone identifiers").liEnd
    .ulEnd

    out.h2("id='units'").w("Units").h2End
    out.p.w("The following downloads of the <a href='/doc/Units'>unit</a> database are available:").pEnd
    out.ul
      .li.a(`/download/units.txt`).w("Units Text").aEnd.w(": flat text file of unit identifiers").liEnd
    .ulEnd

    out.h2("id='locales'").w("Locales").h2End
    out.p.w("The following are plain text property files for localized tag names:").pEnd
    out.ul
    typeof.pod.files.findAll |f| { f.pathStr.startsWith("/locale/") }.sort.each |f|
    {
      out.li.a(`/download/locale/${f.name}`).w(f.name).aEnd
    }
    out.ulEnd

    out.h2("id='equip-points'").w("Equip Points").h2End
    out.p.w("The following are plain text point listings for specific equip types:").pEnd
    out.ul
    typeof.pod.files.findAll |f| { f.pathStr.startsWith("/equips/") }.sort.each |f|
    {
      out.li.a(`/download/equip-points/${f.basename}`).w(f.basename).aEnd
    }
    out.ulEnd
  }
}

**************************************************************************
** ForumRender
**************************************************************************

internal class HaystackForumRenderer : ForumRenderer
{
  override Void onFandocLink(Link link)
  {
    // check tag name
    tag := Lib.cur.tags.map[link.uri]
    if (tag != null) { link.uri = "/tag/${tag.name}"; link.isCode = true }
  }
}

