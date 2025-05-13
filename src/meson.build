date_utils = library('date_utils', 'date_utils.f90')
date_utils_dep = declare_dependency(
  link_with: date_utils,
  include_directories: include_directories('.')
)

ch1 = library('ch1', 'ch1.f90', 'caldat.f90', dependencies: [date_utils_dep])
ch1_dep = declare_dependency(
  link_with: ch1,
  include_directories: include_directories('.')
)

badluk = executable('badluk', 
  sources: 'badluk.f90',
  dependencies: [ch1_dep, date_utils_dep]
)

# add the other library targets as we progress here
