# encoding: utf-8
require 'kitchen/driver/vagrant'

module Kitchen
  module Driver
    # Uses Vagrant to drive Kitchen. It uses Vagrant provisioning instead
    # of SSH.
    #
    # It is based on the Vagrant driver.
    #
    # @author Christian Holtje <docwhat@gerf.org>
    class VagrantProvision < Vagrant
      def converge(state)
        create_vagrantfile
        run 'vagrant provision', environment: nil
      end
    end
  end
end
