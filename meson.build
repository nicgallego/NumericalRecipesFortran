project('NumericalRecipesFortran', 'fortran', meson_version: '>=1.0', version: '1.0')

# for test coverage builds
if get_option('buildtype') == 'debug'
  add_project_arguments('-Db_coverage=true', '-fprofile-arcs', '-ftest-coverage', language: 'fortran')
  add_project_link_arguments('-lgcov', language: 'fortran')
endif

subdir('src')
subdir('tests')
subdir('doc')
  
test_bins = [ch2_tester, tester]
# custom target test coverage depending on one of the tester programs, meson takes care of the rest
if get_option('buildtype') == 'debug'
  #  custom_target('gcov',
  #    output: 'coverage.html',
  #    command: ['sh', '-c',
  #      '''
  #      ninja -C ${MESON_BUILD_ROOT} test &&
  #      gcovr -r ${MESON_SOURCE_ROOT}/src --object-directory ${MESON_BUILD_ROOT}/src --html --html-details -o ${MESON_BUILD_ROOT}/coverage.html --fail-under-line 80
  #      '''
  #      ],
  #    depends: test_bins,
  #    build_by_default: false,
  #    ) 
  #  message('after adding gcov')

custom_target('coverage.html',
  output : 'coverage.html',
  command : [
    'sh', '-c',
    'ninja -C @0@ test && gcovr -r @1@ --object-directory @0@ --html --html-details -o @0@/coverage.html --fail-under-line 80'.format(
      meson.project_build_root(),
      meson.project_source_root()/'src'
    )
  ],
  depends : test_bins,  # if needed
  build_always_stale : true
)

message('Build dir: ' + meson.project_build_root())
message('Source dir: ' + meson.project_source_root()/'src')

endif
