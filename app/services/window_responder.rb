class WindowResponder < ActionController::Responder
  cattr_accessor :window_layout
  self.window_layout = 'window_body'

  def render(*args)
    options = args.extract_options!
    if request.xhr?
      options.merge! layout: window_layout
    end
    controller.render *args, options
  end

  def default_render(*args)
    render(*args)
  end
end