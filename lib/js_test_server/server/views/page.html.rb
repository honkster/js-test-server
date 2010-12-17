class JsTestServer::Server::Views::Page < Erector::Widget
  def content(&block)
    rawtext %Q{<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">}
    html :xmlns => "http://www.w3.org/1999/xhtml", :"xml:lang" => "en" do
      head do
        meta :"http-equiv" => "Content-Type", :content => "text/html;charset=UTF-8"
        title title_text
        head_content
      end
      body do
        body_content(&block)
      end
    end
  end

  protected

  def head_content
  end

  def title_text
    "Js Test Server"
  end

  def body_content(&block)
    yield(self)
  end

  def javascript(params={})
    if params.is_a?(Hash) && params[:src]
      script({:type => "text/javascript"}.merge(params))
    else
      super
    end
  end

  def path
    helpers.rack_request.path_info
  end
end
