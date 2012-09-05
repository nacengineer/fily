require 'haml'

module ApplicationHelper

  def ios_links( opts={} )
    # rewrite dir for nginx if asset pipeline
    dir = asset_pipeline?(opts) ? "ccap-images" : "images"
    capture_haml do
      haml_tag :link, :href  => "/#{dir}/apple-touch-icon.png",
                      :rel   => "apple-touch-icon"
      haml_tag :link, :href  => "/#{dir}/apple-touch-icon-72x72.png",
                      :rel   => "apple-touch-icon",
                      :sizes => "72x72"
      haml_tag :link, :href  => "/#{dir}/apple-touch-icon-114x114.png",
                      :rel   => "apple-touch-icon",
                      :sizes => "114x114"
    end
  end

  def asset_pipeline?( opts={} )
    opts.has_key?(:asset_pipeline) && opts[:asset_pipeline]
  end

end
