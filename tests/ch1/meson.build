
tests = [
  'julday',
  'date_utils',
  'badluck',
  'caldat',
  ]
# if the .mod cannot be found, forgot to add the test into the test list above :)

test_srcs = files(
  'tester.f90',
)

foreach t : tests
  test_srcs += files('test_@0@.f90'.format(t.underscorify()))
endforeach

tester = executable(
  'tester',
  sources: test_srcs,
  dependencies: [testdrive_dep, ch1_dep, date_utils_dep,
                ]
)

test('ch1 tests', tester)

foreach t: tests
  test(t, tester, args: t)
endforeach

# benchmarks here

# declare an executable and register it as benchmark
ps_benchmark_exe = executable(
  'ps_benchmark',
  ['ps_benchmark.f90', 'ps_algorithms.f90'],
  dependencies: [],
  install: false
)
benchmark('ps_benchmark', ps_benchmark_exe) 
