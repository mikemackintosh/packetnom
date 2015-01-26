module Packetnom
    
    class Packet
        
        class Eth

            # Attributes
            attr_accessor :dst
            attr_accessor :src
            attr_accessor :type

            # Initialize the packet
            def initialize( bytes )               
                # Layer 2
                @dst = bytes[0..5].join(':')
                @src = bytes[6..11].join(':')
                @type = bytes[12..13].join() # http://en.wikipedia.org/wiki/EtherType
            end

            def type
               types = {
                    "0800" => "ip",
                }

                types[ @type ]
            end
            alias_method :ethertype, :type

        end

    end

end