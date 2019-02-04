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

  def form_for(*args, **opts, &block)
    opts[:builder] ||= CustomFormBuilder
    super(*args, **opts, &block)
  end

  private

  def props_path(path)
    return path ? "props/#{path.to_s.pluralize}" : "props"
  end
end
