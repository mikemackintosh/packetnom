module Packetnom
    
    class Packet
        
        class IPv4

            # Attributes
            attr_accessor :version
            attr_accessor :ihl
            attr_accessor :ds
            attr_accessor :len
            attr_accessor :id
            attr_accessor :flags
            attr_accessor :offset
            attr_accessor :ttl
            attr_accessor :proto
            attr_accessor :sum
            attr_accessor :src
            attr_accessor :dst

            # Initialize the packet
            def initialize( bytes )
                offset = Hash[bytes[0..24].map.with_index.to_a]['45']

                @version = bytes[offset].split(//)[0]
                @ihl = bytes[offset].split(//)[1]
                @ds = bytes[offset+1]
                @len = bytes[offset+2..offset+3].join().to_i(16)
                @id = bytes[offset+4..offset+5].join().to_i(16)

                options = bytes[offset+6..offset+7].join().to_i(16).to_s(2).rjust(16, '0')
                @flags = options[0..2].to_i(2).to_s(10)
                @offset = options[3..15].to_i(2).to_s(10)

                @ttl = bytes[offset+8].to_i(16)
                @proto = bytes[offset+9].to_i(16)
                @sum = bytes[offset+10..offset+11].join()
                @src = bytes[offset+12..offset+15].map{|octet| octet.to_i(16).to_s(10)}.join('.')
                @dst = bytes[offset+16..offset+19].map{|octet| octet.to_i(16).to_s(10)}.join('.')
            end

            alias_method :length, :len
            alias_method :checksum, :sum

            def protonum
                @proto.to_i
            end
            def proto
                protocol( @proto.to_i )
            end
            alias_method :protocol, :proto

            def src
               IPAddress @src
            end
            alias_method :source, :src
            alias_method :from, :src


            def dst
                IPAddress @dst
            end
            alias_method :dest, :dst
            alias_method :target, :dst

        private

            def protocol( proto )
               protocols = {
                    6 => "tcp",
                    17 => "udp",
                }

                protocols[ proto ]
            end

        end

    end

end