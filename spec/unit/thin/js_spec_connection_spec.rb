require File.expand_path("#{File.dirname(__FILE__)}/../unit_spec_helper")

module Thin
  describe JsSpecConnection do
    describe "#process" do
      attr_reader :connection, :result
      before do
        @connection = JsSpecConnection.new('signature')
        stub(connection).socket_address {'0.0.0.0'}

        @result = ""
        stub(EventMachine).send_data do |signature, data, data_length|
          result << data
        end
      end

      describe "when the response code is not 0" do
        attr_reader :somedir_resource
        before do
          mock(app = Object.new).call(is_a(Hash)) do
            [200, {}, 'The Body']
          end
          connection.app = app
        end

        it "sends the response to the socket and closes the connection" do
          mock(connection).close_connection_after_writing
          connection.receive_data "GET /specs HTTP/1.1\r\nHost: _\r\n\r\n"
          result.should include("The Body")
        end
      end

      describe "when the response code is 0" do
        attr_reader :somedir_resource
        before do
          mock(app = Object.new).call(is_a(Hash)) do
            [0, {}, 'The Body']
          end
          connection.app = app
        end

        it "does not send data to the socket and keeps it open" do
          dont_allow(connection).close_connection_after_writing
          connection.receive_data "GET /specs HTTP/1.1\r\nHost: _\r\n\r\n"
          result.should_not include("The Body")
        end
      end
    end
  end
end