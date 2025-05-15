src_root = meson.global_source_root()

input_dirs = [
  src_root / 'src',
  src_root / 'tests',
  src_root / 'doc', 
  ]

# add here individual markdown documents not part of source to trigger compilation when edited
dp = src_root / 'doc'
doc_markdown = [
  dp / 'index.md',
  dp / 'ch_01_preeliminaries.md',
  dp / 'ch_02_linear_equations.md',
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
    input: [doxygen_conf, doc_markdown],
    output: 'html',
    command: [doxygen, '@INPUT@'],
    depends: [ch1, date_utils, badluk, tester, ps_benchmark_exe],
    build_by_default: false
  )
else 
  message('Doxygen[optional] dependency not found, doc target was not generated')
endif
