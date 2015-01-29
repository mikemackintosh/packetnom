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
                @type = bytes[12..13].join # http://en.wikipedia.org/wiki/EtherType

                # WHY DOES THIS HAVE PADDING ON ETHERTYPE ON REPLAY?!
                if @type.eql? '0000'
                    @type = bytes[13..14].join
                end
                
            end

            def type? (is)
                if type.eql? type
                    return true
                end

                false
            end

            def type
               types = {
                    "0800" => "ip",
                    "0801" => "x.75",
                    "0802" => "nbs",
                    "0803" => "ecma",
                    "0804" => "chaosnet",
                    "0805" => "x.25",
                    "0806" => "arp",
                    "814C" => "snmp",
                    "86dd" => "ipv6"
                }

                types[ @type ]
            end
            alias_method :ethertype, :type

        end

    end

end