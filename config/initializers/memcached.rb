# REFACTOR: To accomodate for multiple memcached servers in each
# environment
require 'socket'
include Socket::Constants

class MEMCACHED
  class << self
    attr_accessor :host, :port
  end

  def self.up?
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    sockaddr = Socket.pack_sockaddr_in( self.port, self.host )
    begin
      socket.connect( sockaddr )
    rescue #Errno
      # do nothing here - nil will be returned above
    end
  end
end