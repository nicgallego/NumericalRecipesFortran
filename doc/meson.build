input_dirs = [
  meson.source_root() / 'src',
  meson.source_root() / 'tests'
  ]
  
  
doxygen_conf = configure_file(
  input: 'Doxyfile.in',
  output: 'Doxyfile',
  configuration: {
    'INPUT_DIR': ' '.join(input_dirs),
    'OUTPUT_DIR': meson.current_build_dir()
    }
  )

doxygen = find_program('doxygen', required: false) 

if ( doxygen.found() ) 
doxygen_target = custom_target(
  'doc',
  input: doxygen_conf,
  output: 'html',
  command: [doxygen, '@INPUT@'],
  depends: [ch1, date_utils, badluk, tester, ps_benchmark_exe],
  build_by_default: false
)
else 
  message('Doxygen[optional] dependency not found, doc target was not generated')
endif
