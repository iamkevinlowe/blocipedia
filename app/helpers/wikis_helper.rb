module WikisHelper
  def private_icon(wiki)
    if wiki.private?
      "<span class='glyphicon glyphicon-lock'
      style='color: red; font-size: 0.6em;'>
      </span>".html_safe
    else
      ""
    end
  end
end
