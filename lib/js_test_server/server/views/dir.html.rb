class JsTestServer::Server::Views::Dir < JsTestServer::Server::Views::Page
  needs :relative_path, :absolute_path
  attr_reader :relative_path, :absolute_path
  protected

  def body_content
    ul do
      ::Dir.glob("#{absolute_path}/*").inject("") do |html, file|
        li do
          a(
            ::File.basename(file),
            :href => "#{relative_path}/#{::File.basename(file)}".gsub("//", "/")
          )
        end
      end
    end
  end

  def title_text
    "Contents of #{relative_path}"
  end
end
