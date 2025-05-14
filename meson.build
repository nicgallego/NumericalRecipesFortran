project('NumericalRecipesFortran', 'fortran', meson_version: '>=0.50', version: '1.0')

# for test coverage builds
if get_option('buildtype') == 'debug'
  add_project_arguments('-fprofile-arcs', '-ftest-coverage', language: 'fortran')
  add_project_link_arguments('-lgcov', language: 'fortran')
endif

subdir('src')
subdir('tests')
subdir('doc')
