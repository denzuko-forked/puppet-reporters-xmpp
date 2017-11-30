require 'puppet'
require_relative 'reporter'

Puppet::Reports.register_report(:xmpp) do
  
  @reporter = Reporter.new

  desc @reporter.description
 
  def process
    next if self.status != 'failed' and @reporter.environment? self.environment
      
    Puppet.debug "Sending status for #{self.host} to XMMP user #{self.target}"
    
    @reporter.connect!
    @reporter.client.send! "Puppet run failed!",
      "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}",
      :normal
  end
end
