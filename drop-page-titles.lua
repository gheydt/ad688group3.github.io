-- Two included pages leak their YAML title line into the report as a heading
-- ("title: Introduction"); drop those so the Word report only shows real sections.
function Header(el)
  if pandoc.utils.stringify(el.content):match("^title:") then
    return {}
  end
end
