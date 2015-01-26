module Kn0x
    
    class Packet
        
        class Tcp
            
            # Attributes
            attr_accessor :src_port
            attr_accessor :dst_port
            attr_accessor :seq
            attr_accessor :ack
            attr_accessor :offset
            attr_accessor :reserved
            attr_accessor :ecn
            attr_accessor :cbits
            attr_accessor :win
            attr_accessor :sum
            attr_accessor :uptr

            # Initialize the packet
            def initialize( bytes )
                @packet = bytes
                
                @src_port = bytes[34..35].join().to_i(16).to_s(10).to_i
                @dst_port = bytes[36..37].join().to_i(16).to_s(10).to_i
                
                @seq = bytes[38..41].join().to_i(16).to_s(10).to_i

                @ack = bytes[42..45].join().to_i(16).to_s(10).to_i

                @offset = bytes[46].split(//)[0].to_i(16).to_s(10)

                @reserved = bytes[46].split(//)[1].to_i(16).to_s(10)
                @ecn = bytes[47].split(//)[0].to_i(16).to_s(10)
                @cbits = bytes[47].split(//)[1].to_i(16).to_s(10)

                @win = bytes[48..49].join().to_i(16)
                @sum = bytes[50..51].join().to_i(16)
                @uptr = bytes[52..53].join().to_i(16)
            end

            alias_method  :source_port, :src_port
            alias_method  :sport, :src_port

            alias_method  :dest_port, :dst_port
            alias_method  :dport, :dst_port

            alias_method :window, :win
            alias_method :windowsize, :win
            alias_method :size, :win

            alias_method :checksum, :sum
            alias_method :urgent, :uptr

            def cbits
                @cbits
            end
            alias_method :controlbits, :cbits
            alias_method :control, :cbits

        end

    end

end