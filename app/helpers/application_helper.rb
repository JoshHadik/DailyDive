module ApplicationHelper
  def action_path(scene, *args)
    send("actions_#{scene}_path", *args)
  end

  def scene_path(scene, *args)
    send("scenes_#{scene}_path", *args)
  end

  def render_prop(path=nil, prop, **locals)
    props_path(path)
    render(partial: "#{params[:controller]}/#{props_path(path)}/#{prop}", locals: locals)
  end

  def render_screen(screen, active=false, **locals)
    tag = screen.to_s.gsub(/_/, "-").concat('-screen')
    content_tag(:div, class: "screen #{tag}", id: "#{tag}") do
      render_prop(:screens, "#{screen}_screen", **locals)
    end
  end

  def form_for(*args, **opts, &block)
    opts[:builder] ||= CustomFormBuilder
    super(*args, **opts, &block)
  end

  def show_popup_card_link(screen_or_title, screen=nil, *args, **opts, &block)
    if block_given?
      data_tag = show_popup_data_tag(screen_or_title)
      link_to('#', *args, **opts.merge(data: data_tag), &block)
    else
      data_tag = show_popup_data_tag(screen)
      link_to(screen_or_title, '#', *args, **opts.merge(data: data_tag))
    end
  end

  private

  def show_popup_data_tag(screen)
    {
      "action" => "showPopupCard",
      "screen-tag" => screen.to_s.gsub(/_/, '-')
    }
  end

  def props_path(path)
    return path ? "props/#{path.to_s.pluralize}" : "props"
  end
end
