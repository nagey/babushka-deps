dep 'nodejs.src', :version do
  nodepath = "/usr/local/nodejs"
  
  requires "node_path".with(:nodepath => nodepath)
  version.default!('0.10.16')
  source "http://nodejs.org/dist/v#{version}/node-v#{version}.tar.gz"
  provides "node ~> #{version}"
  prefix nodepath
  met? { in_path? "node >= #{version}" }
end

dep "node_path", :nodepath do
  met? { shell? "grep #{nodepath} /etc/profile" }
  meet { sudo "echo PATH=#{nodepath}/bin:$PATH >> /etc/profile" }
end
  