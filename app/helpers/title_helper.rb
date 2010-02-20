module TitleHelper
  def title_base
    'CollEDGE'
  end

  def page_title!(title)
    @page_title = title + ' [CollEDGE]'
  end

  def page_title_full!(title)
    @page_title = title
  end

  def page_title(title = nil)
    @page_title || title_base
  end
end