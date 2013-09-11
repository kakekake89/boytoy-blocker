class JoinHtmlOutput
  def initialize(app)
    @app = app
  end

  def call(env)

    # Call the underlying application, return a standard Rack response

    status, headers, response = @app.call(env)

    # Join the HTML

    if headers['Content-Type'] =~ /text\/html/
      response.each do |chunk| 
        [
          [/[\r\n]+/, ''],
          [/>\s+/, '>'],
          [/>\s+</, '><'],
          [/; \s+/, '; '],
          [/{ \s+/, '{ '],
          [/<!--(.|\s)*?-->/, '']
        ].each do |regex, substitute|
          chunk.gsub! regex, substitute
        end
      end
    end

    # Return the new Rack response

    [status, headers, response]
  end
end

