ch1 = library('ch1', 'ch1.f90')

ch1_dep = declare_dependency(
  link_with: ch1,
  include_directories: include_directories('.')
)

executable('badluk', 
  sources: 'badluk.f90',
  dependencies: [ch1_dep]
  )

# add the other library targets as we progress here
