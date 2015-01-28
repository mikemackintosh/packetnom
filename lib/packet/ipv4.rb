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
                @version = bytes[14].split(//)[0]
                @ihl = bytes[14].split(//)[1]
                @ds = bytes[15]
                @len = bytes[16..17].join().to_i(16)
                @id = bytes[18..19].join()

                @flags = bytes[20].split(//)[0].to_i(16) #todo
                @offset = "#{bytes[20].split(//)[1]}#{bytes[21]}".to_i(16) #todo

                @ttl = bytes[22].to_i(16)
                @proto = bytes[23].to_i(16)
                @sum = bytes[24..25].join().to_i(16)
                @src = bytes[26..29].map{|octet| octet.to_i(16).to_s(10)}.join('.')
                @dst = bytes[30..33].map{|octet| octet.to_i(16).to_s(10)}.join('.')
               
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