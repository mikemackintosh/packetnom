# Created by hand, like a real man
Gem::Specification.new do |s|

  s.name        = 'packetnom'
  s.version     = '0.0.2'
  s.date        = '2015-01-26'
  s.summary     = "PacketNom, nom, nom, nom"
  s.description = "PacketNom - Best way to view, consume and replay packets with ruby"
  s.authors     = ["Mike Mackintosh"]
  s.email       = 'm@zyp.io'
  s.homepage    =
    'http://github.com/mikemackintosh/packetnom'

  s.license       = 'not-yet-decided'
  
  s.files       = [
    "lib/packetnom.rb", 
    "lib/packet/eth.rb",
    "lib/packet/ip.rb",
    "lib/packet/tcp.rb",
  ]

  s.add_runtime_dependency 'ffi-pcap'
  s.add_runtime_dependency 'ipaddress', '>= 0.8'
  s.add_runtime_dependency 'hexdump'

end