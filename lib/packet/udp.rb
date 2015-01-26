module Packetnom
    
    class Packet
        
        class Udp
            
            # Attributes
            attr_accessor :src_port
            attr_accessor :dst_port
            attr_accessor :length
            attr_accessor :sum

            # Initialize the packet
            def initialize( bytes )                
                @src_port = bytes[34..35].join().to_i(16).to_s(10).to_i
                @dst_port = bytes[36..37].join().to_i(16).to_s(10).to_i
                
                @length = bytes[38..39].join().to_i(16).to_s(10).to_i
                @sum = bytes[40..41].join().to_i(16).to_s(10).to_i
            end

            alias_method  :source_port, :src_port
            alias_method  :sport, :src_port
            alias_method  :dest_port, :dst_port
            alias_method  :dport, :dst_port
            alias_method :len, :length
            alias_method :checksum, :sum
            
        end

    end

end