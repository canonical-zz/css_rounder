require 'commands'

module CSSRounder

  def self.included(base)
    base.alias_method_chain :expand_stylesheet_sources, :pullquote
  end

  # wedge a bit of functionality into 'stylesheet_link_tag' so that we can pass :pullquote
  # and it will gather all of the "pullquote.css" files in subdirs under stylesheets/
  def expand_stylesheet_sources_with_pullquote(sources, recursive)
    if sources.first == :pullquote
      collect_asset_files(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR, '**', 'pullquote.css')
    else
      expand_stylesheet_sources_without_pullquote(sources, recursive)
    end
  end
end