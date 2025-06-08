!> @brief powers of the "Golden-Mean"
program ps_benchmark

   ! dependencies
   use, intrinsic :: iso_fortran_env, only: real32
   use ps_algorithms, only : ps_powers, ps_multiplications, ps_recursion, validate_allocate
   implicit none

   ! internal variables
   real(kind=real32), allocatable :: p_ref(:), p_mult(:), p_rec(:)
   integer, parameter :: n = 64

   real(kind=real32) :: t_start, t_end    ! time variables
   integer :: k

   real(kind=real32), allocatable :: ep_mult(:), ep_rec(:)

   ! experimenting with kind
   integer,parameter :: kc = kind(' ')
   integer,parameter :: kl = kind(.true.)

   ! executable body
   write (*,*) 'Computing reference values phi(k) for k=1...', n
   call cpu_time(t_start)
   p_ref = ps_powers(n)
   call cpu_time(t_end)
   print '(a,f16.8,a)', "... took ", (t_end - t_start)*1000.0_real32, " ms"

   write (*,*) 'computing using multiplications ', n
   call cpu_time(t_start)
   p_mult = ps_multiplications(n)
   call cpu_time(t_end)
   print '(a,f16.8,a)', "... took ", (t_end - t_start)*1000.0_real32, " ms"

   write (*,*) 'computing using recursion ', n
   call cpu_time(t_start)
   p_rec = ps_recursion(n)
   call cpu_time(t_end)
   print '(a,f16.8,a)', "... took ", (t_end - t_start)*1000.0_real32, " ms"

   write (*,*) ''
   write (*,*) '|        `k`    |     `p_ref(k)`       |         `p_mult(k)`        |      `p_rec(k)`    |'
   write (*,*) '| ------------: | -------------------- | -------------------------- | ------------------ |'
   do k=1,n
      write (*,*) '|', k, '|', p_ref(k), '|', p_mult(k), '|', p_rec(k), '|'
   end do

   write (*,*) 'Error statistics of algorithms with respect to reference values:'
   write (*,*) '|                    `|p_mult - p_ref|`   |    `|p_rec - p_ref|`               |'
   write (*,*) '|-----------------------------------------|------------------------------------|'

   call validate_allocate(n,ep_mult)
   ep_mult = abs(p_mult - p_ref)

   call validate_allocate(n, ep_rec)
   ep_rec = abs(p_rec - p_ref)

   write (*,*) '| min    |', minval(ep_mult), '|', minval(ep_rec), '|'
   write (*,*) '| avg    |', sum(ep_mult)/n, '|', sum(ep_rec)/n, '|'
   write (*,*) '| max    |', maxval(ep_mult), '|', maxval(ep_rec), '|'
   write (*,*) '|-------------------------------------------------------------------------------'
   write (*,*) 'sizeof(0.0_real32) = ', sizeof(0.0_real32), ' bytes'
   ! playing with kinds... before doing some refactoring for generic functions
   ! print *, "The default character kind is ", kc
   ! print *, "The default logical kind is ", kl
   ! print *, "The real32 kind is ", kind(real32)
   ! print *, "The real32 kind is ", kind(real32)


   ! print *, kind(1.0)       ! maybe 4
   ! print *, kind(1.0d0)     ! maybe 8
   ! print *, kind(.true.)    ! maybe 3 (as you saw)


end program
