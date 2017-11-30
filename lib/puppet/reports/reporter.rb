require 'hiera'
require 'puppet'

begin
  require 'xmpp4r/client'

rescue LoadError => e
  Puppet.info "You need the `xmpp4r` gem to use the XMPP report"
end

class Reporter
  attr_accessor :client, :config, :description
  
  include Jabber

  def initialize()
    @hiera = Hiera.new
    
    self.description = "Send notification of failed reports to an XMPP user."
    self.config = @hiera.lookup('reporters::xmpp', {
      :server      => '',
      :user        => '',
      :secret      => '',
      :target      => '',
      :environment => :ALL
    })
    self.client = nil
  end

  def target
    "#{self.config[:target]}@#{self.config[:server]}"
  end
  
  def jid
    "#{self.config[:user]}@#{self.config[:server]}"
  end
  
  def connect!
    self.client = Client::new JID::new(self.jid)
    self.client.connect
    self.client.auth config[:secret]
  end
   
  def environment?(env)
    self.config[:environment].include?(env) or self.config[:environment] == :ALL
  end
  
  def send!(subject, body, type = :normal, *id)
    self.client.send Message::new(self.target, body)
                              .set_type(type)
                              .set_id(id or '1')
                              .set_subject(subject)
  end
  
end
