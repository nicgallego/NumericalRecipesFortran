tests = [
  'gaussj',
  ]

test_srcs = files( 'ch2_tester.f90' )

foreach t : tests
  test_srcs += files('test_@0@.f90'.format(t.underscorify()))
endforeach

ch2_tester = executable(
  'ch2_tester',
  sources: test_srcs,
  dependencies: [testdrive_dep, ch2_dep,
    ]
  )

test('ch2 tests', ch2_tester)

foreach t: tests
  test(t, ch2_tester, args: t)
endforeach

# benchmarks here
