#
# Copyright (c) 2011 Red Hat, Inc.
#
# This software is licensed to you under the GNU Lesser General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (LGPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of LGPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/lgpl-2.0.txt.
#
# Jeff Ortel <jortel@redhat.com>
#

require 'gofer/messaging/pkg'
require 'gofer/messaging/dispatcher'

module Gofer

  class Stub
  
    def initialize(pid, classname, opts={})
      @log = Gofer::logger()
      @pid = pid
      @classname = classname
      @opts = opts
    end
    
    def send(name, *args, &block)
      return self.method_missing(name, *args, &block) 
    end
  
    def method_missing(sym, *args, &block)
      begin
        @log.info("invoke: #{@classname}.#{sym}(#{args})")
        request = {
          :classname=>@classname,
          :method=>sym,
          :args=>args,
          :kws=>{}
        }
        return _send(request)
      rescue NoMethodError=>ex
        raise Exception.new("#{ex.name}")
      end
    end
    
    def to_s()
      return "#{@classname} @ '#{@pid}'"
    end
    
    private
  
    def _send(request)
      method = @opts[:method]
      window = @opts[:window]
      window = (window ? window.hash : nil)
      any = @opts[:any]
      if @pid.is_a?(Array)
        return method.broadcast(
          @pid,
          request,
          :window=>window,
          :any=>any)
      else
        return method.send(
          @pid,
          request,
          :window=>window,
          :any=>any)
      end
    end
    
  end

end
