# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "table_locking/version"

Gem::Specification.new do |s|
  s.name        = "table_locking"
  s.version     = TableLocking::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andreas Wurm"]
  s.email       = ["andreaswurm@gmx.de"]
  s.homepage    = ""
  s.summary     = "This gem extends ActiveRecord with table-level locking."
  s.description = "This gem extends ActiveRecord with table-level locking."


  s.add_dependency 'activerecord'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
