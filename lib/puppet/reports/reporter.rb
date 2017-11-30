require 'hiera'
require 'puppet'

begin
  require 'hiera'
  require 'xmpp4r/client'
  include Jabber
rescue LoadError => e
  Puppet.info "You need the `xmpp4r` gem to use the XMPP report"
end

class Reporter
  attr_accessor :client, :config, :description

  def initialize()
    self.description = "Send notification of failed reports to an XMPP user."
    self.config = Hiera::lookup('reports::xmpp', {
      :server      => '',
      :user        => '',
      :secret      => '',
      :target      => '',
      :environment => :ALL
    })
    self.client = nil
  end
  public:
  def target
    "#{self.config[:target]}@#{self.config[:server]}"
  end
  
  def jid
    "#{self.config[:user]}@#{self.config[:server]}"
  end
  
  def connect!
    self.client = Client::new JID::NEW(self.jid)
    self.client.connect
    self.client.auth config[:secret]
  end
   
  def environment?(env)
    self.config[:environment].include?(env) or self.config[:environment] == :ALL
  end
end
