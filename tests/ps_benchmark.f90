!> @brief powers of the "Golden-Mean"
program ps_benchmark

   ! dependencies
   use, intrinsic :: iso_fortran_env, only: real32, real64
   use ps_algorithms, only : ps_powers, ps_multiplications, ps_recursion
   implicit none

   ! internal variables
   real(kind=real64), allocatable :: p_ref(:), p_mult(:), p_rec(:)
   integer, parameter :: n = 256
   real(kind=real64) :: t_start, t_end    ! time variables

   ! executable body
   write (*,*) 'Computing reference values phi(k) for k=1...', n
   call cpu_time(t_start)
   p_ref = ps_powers(n)
   call cpu_time(t_end)
   print '(a,f16.8,a)', "... took ", (t_end - t_start)*1000.0_real64, " ms"

   write (*,*) 'computing using multiplications ', n
   call cpu_time(t_start)
   p_mult = ps_multiplications(n)
   call cpu_time(t_end)
   print '(a,f16.8,a)', "... took ", (t_end - t_start)*1000.0_real64, " ms"

   write (*,*) 'computing using recursion ', n
   call cpu_time(t_start)
   p_rec = ps_recursion(n)
   call cpu_time(t_end)
   print '(a,f16.8,a)', "... took ", (t_end - t_start)*1000.0_real64, " ms"

end program
