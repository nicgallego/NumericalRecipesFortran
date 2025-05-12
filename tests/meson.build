testdrive_dep = dependency('test-drive', fallback: ['test-drive', 'testdrive_dep'])

tests = [
  'julday',
  'date_utils'
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
  dependencies: [testdrive_dep, ch1_dep, date_utils_dep]
)


test('all tests', tester)

foreach t: tests
  test(t, tester, args: t)
endforeach
