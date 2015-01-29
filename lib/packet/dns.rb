module Packetnom
    
    class Protocol
        
        class Dns
            
            # Attributes
            attr_accessor :id
            attr_accessor :qr
            attr_accessor :opcode
            attr_accessor :aa
            attr_accessor :tc
            attr_accessor :rd
            attr_accessor :ra
            attr_accessor :z
            attr_accessor :ad
            attr_accessor :cd
            attr_accessor :rcode
            attr_accessor :questions
            attr_accessor :answers
            attr_accessor :authorities
            attr_accessor :rrs

            # Initialize the packet
            def initialize( bytes )     

                # Get the ID
                @id = bytes[42..43].join().to_i(16).to_s(10).to_i
                
                # Get next two bytes' options
                options = bytes[44..45].join().to_i(16).to_s(2).rjust(16, '0')
                @qr = options[0] # bit 16
                @opcode = options[1..4].to_i(2).to_s(10)
                @aa = options[5]
                @tc = options[6]
                @rd = options[7]
                @ra = options[8]
                @z = options[9]
                @ad = options[10]
                @cd = options[11]
                @rcode = options[12..15].to_i(2).to_s(10)

                @questions = bytes[46..47].join().to_i(16).to_s(10).to_i
                @answers = bytes[48..49].join().to_i(16).to_s(10).to_i
                @authorities = bytes[50..51].join().to_i(16).to_s(10).to_i
                @rrs = bytes[52..53].join().to_i(16).to_s(10).to_i
                
                # Drop the DNS headers
                bytes = bytes.drop(54)
                #puts bytes
                
                bytes = bytes.pack('H*')
                puts bytes.inspect

            end

            # Returns true if it is a query
            def is_query?
                if @qr.to_i.eql? (0)
                    return true
                end

                false
            end

            def is_authoritative?
                if @aa.to_i.eql? (0)
                    return false
                end

                true
            end

            def is_truncated?
                if @tc.to_i.eql? (0)
                    return false
                end

                true
            end

            def status
                return query_opcode( @rcode.to_i )
            end

        private

            def query_opcode(o)
                qopcode = {0 => 'QUERY', 1 => 'IQUERY', 2 => 'STATUS', 5 => 'UPDATE'}
                return qopcode[o.to_i]
            end

            def query_type(t)
                qtype = {1=>'A', 2=>'NS', 5=>'CNAME', 6=>'SOA', 12=>'PTR', 15=>'MX',
                 16=>'TXT', 17=>'RP', 18=>'AFSDB', 24=>'SIG', 25=>'KEY', 28=>'AAAA',
                 29=>'LOC', 33=>'SRV', 35=>'NAPTR', 36=>'KX', 37=>'CERT', 39=>'DNAME',
                 41=>'OPT', 42=>'APL', 43=>'DS', 44=>'SSHFP', 45=>'IPSECKEY',
                 46=>'RRSIG', 47=>'NSEC', 48=>'DNSKEY', 49=>'DHCID', 50=>'NSEC3',
                 51=>'NSEC3PARAM', 52=>'TLSA', 55=>'HIP', 99=>'SPF', 249=>'TKEY', 
                 250=>'TSIG', 251=>'IXFR', 252=>'AXFR', 255=>'ANY', 257=>'TYPE257', 
                 32768=>'TA', 32769=>'DLV'}

                return qtype[ t.to_i ]

            end

            def query_class(c)
                qclass = {1=>'IN', 2=>'CS', 3=>'CH', 4=>'Hesiod', 254=>'None', 255=>'*'}

                return qclass[c.to_i]
            end
            
        end

    end

end