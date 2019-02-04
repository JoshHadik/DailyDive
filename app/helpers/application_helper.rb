module ApplicationHelper
  def action_path(scene, *args)
    send("actions_#{scene}_path", *args)
  end

  def scene_path(scene, *args)
    send("scenes_#{scene}_path", *args)
  end

  def render_prop(prop, **locals)
    render(partial: "#{params[:controller]}/props/#{prop}", locals: locals)
  end

  def form_for(*args, **opts, &block)
    opts[:builder] ||= CustomFormBuilder
    super(*args, **opts, &block)
  end
end
